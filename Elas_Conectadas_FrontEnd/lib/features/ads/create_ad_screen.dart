import 'dart:convert';
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
  final String initialCategory;

  const CreateAdScreen({
    super.key,
    this.initialCategory = 'PRODUCT',
  });

  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _regiaoController = TextEditingController();

  late String _categoria;
  final List<ImagemUpload> _imagens = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _categoria = widget.initialCategory == 'SERVICE' ? 'SERVICE' : 'PRODUCT';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _precoController.dispose();
    _regiaoController.dispose();
    super.dispose();
  }

  // ── Seletor de imagens ─────────────────────────────────────────────────────
  Future<void> _pickImages() async {
    final availableSlots = 5 - _imagens.length;
    if (availableSlots <= 0) return;

    final picked = await ImagePicker().pickMultiImage(
      maxWidth: 800,
      imageQuality: 80,
    );
    if (picked.isEmpty) return;

    final selected = picked.take(availableSlots).toList(growable: false);
    final images = <ImagemUpload>[];
    for (final image in selected) {
      images.add(
        ImagemUpload(bytes: await image.readAsBytes(), nome: image.name),
      );
    }

    if (!mounted) return;
    setState(() => _imagens.addAll(images));

    if (picked.length > availableSlots) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você pode anexar no máximo 5 fotos.')),
      );
    }
  }

  // ── Envio do formulário ────────────────────────────────────────────────────
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imagens.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adicione uma foto para publicar o anúncio.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Pega o userId salvo no login
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    String userId = '';
    if (userData != null) {
      // Extrai o id do JSON salvo
      final map = Map<String, dynamic>.from(
        // parse simples sem importar dart:convert extra
        (userData.isNotEmpty) ? _parseSimpleJson(userData) : {},
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
        preco: _precoController.text.trim(),
        categoria: _categoria,
        userId: userId,
        imagens: List.unmodifiable(_imagens),
        regiaoAtendimento: _regiaoController.text.trim(),
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
        _leave(created: true);
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

  void _leave({bool created = false}) {
    if (context.canPop()) {
      context.pop(created);
    } else {
      context.go('/home');
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
          onPressed: _leave,
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

                // ── Galeria de fotos ────────────────────────────────────────
                Text('Fotos', style: AppTextStyles.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Adicione até 5 fotos. A primeira será usada como capa.',
                  style: AppTextStyles.labelMedium,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 116,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _imagens.length + (_imagens.length < 5 ? 1 : 0),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      if (index == _imagens.length) {
                        return InkWell(
                          onTap: _isLoading ? null : _pickImages,
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            width: 112,
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _imagens.isEmpty
                                      ? 'Adicionar fotos'
                                      : 'Adicionar',
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final image = _imagens[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.memory(
                              image.bytes,
                              width: 112,
                              height: 116,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 6,
                            bottom: 6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                index == 0 ? 'Capa' : '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: IconButton.filled(
                              tooltip: 'Remover foto',
                              visualDensity: VisualDensity.compact,
                              onPressed: _isLoading
                                  ? null
                                  : () =>
                                      setState(() => _imagens.removeAt(index)),
                              icon: const Icon(Icons.close, size: 16),
                            ),
                          ),
                        ],
                      );
                    },
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
                  hint:
                      'Descreva seu ${_categoria == 'PRODUCT' ? 'produto' : 'serviço'}...',
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
                  label: 'Preço ou faixa de preço',
                  hint: 'Ex: R\$ 99,90 ou R\$ 100 - R\$ 150',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.text,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Informe o preço ou a faixa de preço'
                      : null,
                ),

                const SizedBox(height: 16),

                // ── Região de atendimento ─────────────────────────────────
                CustomInput(
                  controller: _regiaoController,
                  label: 'Região de atendimento',
                  hint: 'Ex: Itambaracá e região ou a domicílio',
                  prefixIcon: Icons.location_on_outlined,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Informe a região de atendimento'
                      : null,
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
                  onPressed: _leave,
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
                    color: AppColors.primary.withValues(alpha: 0.3),
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
