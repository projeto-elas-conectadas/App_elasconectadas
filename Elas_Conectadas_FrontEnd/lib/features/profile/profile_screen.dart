import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Dados de exemplo — serão substituídos pela API
  static const _name = 'Ana Maria';
  static const _occupation = 'Empreendedora · Artesã em Crochê';
  static const _bio =
      'Empreendedora apaixonada por crochê, compartilho criações e dicas. Sempre aberta a parcerias e colaborações criativas.';
  static const _verified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_name),
        actions: [
          IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textWhite),
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.settings_outlined,
                  color: AppColors.textWhite),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Capa gradiente + Avatar ────────────────────────────────────
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Capa
                Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.gradientEnd],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                // Avatar
                Positioned(
                  bottom: -44,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.primaryLight,
                        child: Text('AM',
                            style: AppTextStyles.displayLarge
                                .copyWith(fontSize: 28)),
                      ),
                      if (_verified)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.check,
                                color: Colors.white, size: 13),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 56),

            // ── Nome e ocupação ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(_name, style: AppTextStyles.headlineMedium),
                  const SizedBox(height: 4),
                  Text(_occupation,
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),

                  // Botão Conectar (visível em perfis alheios)
                  CustomButton(text: 'Conectar', onPressed: () {}, width: 180),

                  const SizedBox(height: 20),

                  // ── Stats ──────────────────────────────────────────────
                  const Row(
                    children: [
                      const _StatCard(value: '12', label: 'Anúncios'),
                      SizedBox(width: 10),
                      const _StatCard(value: '48', label: 'Conexões'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Sobre mim ──────────────────────────────────────────
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sobre Mim', style: AppTextStyles.titleMedium),
                          const SizedBox(height: 8),
                          Text(_bio, style: AppTextStyles.bodyMedium),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;
  const _StatCard({required this.value, required this.label})
      : valueColor = null;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Text(value,
                  style: AppTextStyles.titleLarge
                      .copyWith(color: valueColor ?? AppColors.textDark)),
              const SizedBox(height: 2),
              Text(label, style: AppTextStyles.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}
