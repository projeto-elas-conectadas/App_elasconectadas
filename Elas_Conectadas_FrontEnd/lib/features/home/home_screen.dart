import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/produto_model.dart';
import '../../core/services/produto_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const _tabs = ['Produtos', 'Serviços'];

  List<ProdutoModel> _produtos = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _loadProdutos();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Carrega produtos da API ─────────────────────────────────────────────────
  Future<void> _loadProdutos() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final lista = await ProdutoService.listar();
      if (mounted) setState(() => _produtos = lista);
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = e.toString().replaceAll('Exception: ', ''));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final produtos = _produtos.where((p) => p.categoria == 'PRODUCT').toList();
    final servicos = _produtos.where((p) => p.categoria == 'SERVICE').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elas Conectadas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textWhite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textWhite),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: Column(
        children: [
          // ── Banner de verificação ───────────────────────────────────────────
          _UnverifiedBanner(),

          // ── Feed ─────────────────────────────────────────────────────────────
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? _ErrorView(message: _errorMessage!, onRetry: _loadProdutos)
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _ProdutoFeed(
                            produtos: produtos,
                            onRefresh: _loadProdutos,
                          ),
                          _ProdutoFeed(
                            produtos: servicos,
                            onRefresh: _loadProdutos,
                          ),
                        ],
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        onPressed: _showNewAdSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNewAdSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('O que você quer publicar?', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 8),
            Text('Parcerias serão adicionadas em breve', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 16),
            _SheetOption(
              icon: Icons.shopping_bag_outlined,
              label: 'Produto',
              subtitle: 'Venda algo que você produz',
              onTap: () {
                Navigator.pop(context);
                context.go('/criar-anuncio');
              },
            ),
            _SheetOption(
              icon: Icons.design_services_outlined,
              label: 'Serviço',
              subtitle: 'Ofereça uma habilidade ou serviço',
              onTap: () {
                Navigator.pop(context);
                context.go('/criar-anuncio');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ── Feed de produtos com pull-to-refresh ────────────────────────────────────
class _ProdutoFeed extends StatelessWidget {
  final List<ProdutoModel> produtos;
  final Future<void> Function() onRefresh;
  const _ProdutoFeed({required this.produtos, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (produtos.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          children: [
            const SizedBox(height: 80),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox_outlined, size: 48, color: AppColors.border),
                  const SizedBox(height: 8),
                  Text('Nenhum anúncio aqui ainda', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 4),
                  Text('Puxe para atualizar', style: AppTextStyles.labelMedium),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: produtos.length,
        itemBuilder: (_, i) => _ProdutoCard(produto: produtos[i]),
      ),
    );
  }
}

// ── Card de produto do banco ─────────────────────────────────────────────────
class _ProdutoCard extends StatelessWidget {
  final ProdutoModel produto;
  const _ProdutoCard({required this.produto});

  @override
  Widget build(BuildContext context) {
    final isService = produto.categoria == 'SERVICE';
    final imagemWidget = _buildImagem(produto.imagemUrl);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Imagem / Ícone ─────────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(width: 64, height: 64, child: imagemWidget),
            ),
            const SizedBox(width: 12),

            // ── Conteúdo ───────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chip de categoria
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.chip,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isService ? 'SERVIÇO' : 'PRODUTO',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(produto.nome, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    produto.descricao,
                    style: AppTextStyles.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(produto.precoFormatado, style: AppTextStyles.priceStyle),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Conectar →',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagem(String? imagemUrl) {
    if (imagemUrl == null || imagemUrl.isEmpty) {
      return _iconePlaceholder();
    }
    // Base64
    if (imagemUrl.startsWith('data:image')) {
      try {
        final base64Str = imagemUrl.split(',').last;
        final bytes = base64Decode(base64Str);
        return Image.memory(bytes, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _iconePlaceholder());
      } catch (_) {
        return _iconePlaceholder();
      }
    }
    // URL remota
    return Image.network(imagemUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _iconePlaceholder());
  }

  Widget _iconePlaceholder() {
    return Container(
      color: AppColors.primaryLight,
      child: const Icon(Icons.image_outlined, color: AppColors.primary, size: 32),
    );
  }
}

// ── Tela de erro com botão de retry ─────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_outlined, size: 48, color: AppColors.border),
            const SizedBox(height: 12),
            Text('Não foi possível carregar', style: AppTextStyles.titleMedium),
            const SizedBox(height: 4),
            Text(message, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Tentar novamente')),
          ],
        ),
      ),
    );
  }
}

// ── Banner de conta não verificada ──────────────────────────────────────────
class _UnverifiedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.unverifiedBanner,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Conta não verificada · Verifique para aparecer nas buscas',
              style: AppTextStyles.labelMedium.copyWith(color: AppColors.textMedium),
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/otp', extra: ''),
            child: Text(
              'Verificar →',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Opção do bottom sheet ────────────────────────────────────────────────────
class _SheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  const _SheetOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTextStyles.bodyLarge),
      subtitle: subtitle != null
          ? Text(subtitle!, style: AppTextStyles.labelMedium)
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
      onTap: onTap,
    );
  }
}
