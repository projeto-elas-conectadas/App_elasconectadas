import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/produto_model.dart';
import '../../core/services/produto_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final ProdutoModel? initialProduct;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.initialProduct,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProdutoModel? _product;
  String? _errorMessage;
  bool _isLoading = false;
  int _currentImage = 0;

  @override
  void initState() {
    super.initState();
    _product = widget.initialProduct;
    if (_product == null) _loadProduct();
  }

  Future<void> _loadProduct() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final product = await ProdutoService.buscarPorId(widget.productId);
      if (mounted) setState(() => _product = product);
    } catch (error) {
      if (mounted) setState(() => _errorMessage = error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalhes do anúncio'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _DetailError(message: _errorMessage!, onRetry: _loadProduct)
              : product == null
                  ? const Center(child: Text('Anúncio não encontrado.'))
                  : _buildContent(product),
    );
  }

  Widget _buildContent(ProdutoModel product) {
    final images = [
      product.imagemPrincipal,
      ...product.imagensAdicionais,
    ].where((url) => url.trim().isNotEmpty).toList(growable: false);
    final isService = product.categoria == 'SERVICE';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: images.isEmpty
                ? _imagePlaceholder()
                : PageView.builder(
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() => _currentImage = index);
                    },
                    itemBuilder: (_, index) => Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imagePlaceholder(),
                    ),
                  ),
          ),
          if (images.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: index == _currentImage ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: index == _currentImage
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.chip,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isService ? 'SERVIÇO' : 'PRODUTO',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(product.nome, style: AppTextStyles.headlineMedium),
                const SizedBox(height: 8),
                Text(product.precoFormatado, style: AppTextStyles.priceStyle),
                const SizedBox(height: 18),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Região de atendimento',
                  value: product.regiaoAtendimento,
                ),
                const SizedBox(height: 22),
                Text('Descrição', style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                Text(product.descricao, style: AppTextStyles.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.primaryLight,
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 64,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.labelMedium),
              const SizedBox(height: 2),
              Text(value, style: AppTextStyles.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _DetailError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: onRetry, child: const Text('Tentar novamente')),
          ],
        ),
      ),
    );
  }
}
