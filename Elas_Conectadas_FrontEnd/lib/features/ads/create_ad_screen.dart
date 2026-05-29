import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/produto_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();

  String _categoria = 'PRODUCT'; // PRODUCT ou SERVICE
  Uint8List? _imagemBytes;
  bool _isLoading = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  // ── Seletor de imagem ──────────────────────────────────────────────────────
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 80,
    );
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => _imagemBytes = bytes);
    }
  }

  // ── Envio do formulário ────────────────────────────────────────────────────
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    // Pega o userId salvo no login
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    String userId = '';
    if (userData != null) {
      // Extrai o id do JSON salvo
      final map = Map<String, dynamic>.from(
        // parse simples sem importar dart:convert extra
        (userData.isNotEmpty)
            ? _parseSimpleJson(userData)
            : {},
      );
      userId = map['id']?.toString() ?? '';
    }

    if (userId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sessão expirada. Faça login novamente.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ProdutoService.criar(
        nome: _nomeController.text.trim(),
        descricao: _descricaoController.text.trim(),
        preco: _precoController.text.trim().replaceAll(',', '.'),
        categoria: _categoria,
        userId: userId,
        imagemPrincipal: '', // TODO: implementar upload de imagem via UploadsApi
        regiaoAtendimento: 'A definir', // TODO: adicionar campo na tela
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_categoria == 'PRODUCT' ? 'Produto' : 'Serviço'} cadastrado com sucesso! ✓',
            ),
            backgroundColor: AppColors.success,
          ),
        );
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Map<String, dynamic> _parseSimpleJson(String json) {
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          _categoria == 'PRODUCT' ? 'Novo Produto' : 'Novo Serviço',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Seletor de tipo (Produto / Serviço) ──────────────────────
                Text('Tipo de anúncio', style: AppTextStyles.titleMedium),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _TipoChip(
                      label: 'Produto',
                      icon: Icons.shopping_bag_outlined,
                      selected: _categoria == 'PRODUCT',
                      onTap: () => setState(() => _categoria = 'PRODUCT'),
                    ),
                    const SizedBox(width: 12),
                    _TipoChip(
                      label: 'Serviço',
                      icon: Icons.design_services_outlined,
                      selected: _categoria == 'SERVICE',
                      onTap: () => setState(() => _categoria = 'SERVICE'),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Foto ────────────────────────────────────────────────────
                Text('Foto', style: AppTextStyles.titleMedium),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border, width: 1.5),
                      image: _imagemBytes != null
                          ? DecorationImage(
                              image: MemoryImage(_imagemBytes!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _imagemBytes == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_a_photo_outlined,
                                  color: AppColors.primary, size: 40),
                              const SizedBox(height: 8),
                              Text('Toque para adicionar foto',
                                  style: AppTextStyles.bodyMedium
                                      .copyWith(color: AppColors.primary)),
                            ],
                          )
                        : Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: 16,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                  onPressed: () =>
                                      setState(() => _imagemBytes = null),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Nome ────────────────────────────────────────────────────
                CustomInput(
                  controller: _nomeController,
                  label: 'Nome',
                  hint: _categoria == 'PRODUCT'
                      ? 'Ex: Sandália de Couro Artesanal'
                      : 'Ex: Design de Identidade Visual',
                  prefixIcon: Icons.label_outline,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe o nome' : null,
                ),

                const SizedBox(height: 16),

                // ── Descrição ───────────────────────────────────────────────
                CustomInput(
                  controller: _descricaoController,
                  label: 'Descrição',
                  hint: 'Descreva seu ${_categoria == 'PRODUCT' ? 'produto' : 'serviço'}...',
                  prefixIcon: Icons.description_outlined,
                  maxLines: 4,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Informe a descrição'
                      : null,
                ),

                const SizedBox(height: 16),

                // ── Preço ───────────────────────────────────────────────────
                CustomInput(
                  controller: _precoController,
                  label: 'Preço (R\$)',
                  hint: 'Ex: 99,90',
                  prefixIcon: Icons.attach_money,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Informe o preço';
                    final parsed =
                        double.tryParse(v.trim().replaceAll(',', '.'));
                    if (parsed == null || parsed < 0) {
                      return 'Preço inválido';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // ── Botão de envio ──────────────────────────────────────────
                CustomButton(
                  text: 'Publicar anúncio',
                  onPressed: _handleSubmit,
                  isLoading: _isLoading,
                  icon: Icons.check_circle_outline,
                ),

                const SizedBox(height: 12),

                CustomButton(
                  text: 'Cancelar',
                  onPressed: () => context.go('/home'),
                  isOutlined: true,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Widget auxiliar: chip de tipo ─────────────────────────────────────────────
class _TipoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _TipoChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon,
                color: selected ? Colors.white : AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                color: selected ? Colors.white : AppColors.textDark,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
