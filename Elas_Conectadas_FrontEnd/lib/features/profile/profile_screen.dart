import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/user_model.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/produto_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _user;
  int _adCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await AuthService.currentUser();
    var adCount = 0;

    if (user?.id != null) {
      try {
        final products = await ProdutoService.listar();
        adCount =
            products.where((product) => product.userId == user!.id).length;
      } catch (_) {
        // O perfil continua disponível mesmo se a contagem não carregar.
      }
    }

    if (!mounted) return;
    setState(() {
      _user = user;
      _adCount = adCount;
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da conta?'),
        content:
            const Text('Você precisará informar suas credenciais novamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await AuthService.logout();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final user = _user;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Perfil')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline,
                    size: 48, color: AppColors.primary),
                const SizedBox(height: 12),
                const Text('Não foi possível recuperar os dados da sessão.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Ir para o login'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: RefreshIndicator(
        onRefresh: _loadProfile,
        child: ListView(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
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
                Positioned(
                  bottom: -44,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: AppColors.primaryLight,
                        child: _avatarContent(user),
                      ),
                      if (user.isVerified)
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.check,
                                color: Colors.white, size: 14),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 58),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(user.name, style: AppTextStyles.headlineMedium),
                  if (_hasText(user.occupation)) ...[
                    const SizedBox(height: 4),
                    Text(user.occupation!, style: AppTextStyles.bodyMedium),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _StatCard(value: '$_adCount', label: 'Anúncios'),
                      const SizedBox(width: 10),
                      _StatCard(
                        value: user.isVerified ? 'Sim' : 'Não',
                        label: 'Conta verificada',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _ContactCard(user: user),
                  if (_hasText(user.bio)) ...[
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sobre mim', style: AppTextStyles.titleMedium),
                            const SizedBox(height: 8),
                            Text(user.bio!, style: AppTextStyles.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Sair da conta',
                    onPressed: _logout,
                    isOutlined: true,
                    icon: Icons.logout,
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

  Widget _avatarContent(UserModel user) {
    final initials = Text(
      user.initials,
      style: AppTextStyles.displayLarge.copyWith(fontSize: 28),
    );
    if (!_hasText(user.pfp)) return initials;

    return ClipOval(
      child: Image.network(
        user.pfp!,
        width: 92,
        height: 92,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(child: initials),
      ),
    );
  }

  bool _hasText(String? value) => value != null && value.trim().isNotEmpty;
}

class _ContactCard extends StatelessWidget {
  final UserModel user;

  const _ContactCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      _ContactRow(icon: Icons.email_outlined, value: user.email),
      if (user.phone != null && user.phone!.trim().isNotEmpty)
        _ContactRow(icon: Icons.phone_outlined, value: user.phone!),
      if (user.localizacao.isNotEmpty)
        _ContactRow(icon: Icons.location_on_outlined, value: user.localizacao),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (var index = 0; index < rows.length; index++) ...[
              rows[index],
              if (index < rows.length - 1) const Divider(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const _ContactRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(value, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            children: [
              Text(
                value,
                style: AppTextStyles.titleLarge
                    .copyWith(color: AppColors.textDark),
              ),
              const SizedBox(height: 2),
              Text(label,
                  style: AppTextStyles.labelMedium,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
