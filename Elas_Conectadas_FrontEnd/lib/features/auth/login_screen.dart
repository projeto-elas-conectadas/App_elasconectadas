import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await AuthService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (mounted) context.go('/home');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // ── Logo ────────────────────────────────────────────────────
                _LogoWidget(),

                const SizedBox(height: 40),

                // ── Email ───────────────────────────────────────────────────
                CustomInput(
                  controller: _emailController,
                  label: 'E-mail',
                  hint: 'seu@email.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Informe seu e-mail';
                    if (!v.contains('@')) return 'E-mail inválido';
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ── Senha ───────────────────────────────────────────────────
                CustomInput(
                  controller: _passwordController,
                  label: 'Senha',
                  hint: '••••••••',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Informe sua senha';
                    if (v.length < 6) return 'Mínimo 6 caracteres';
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // ── Botão Entrar ───────────────────────────────────────────
                CustomButton(
                  text: 'Entrar',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 28),

                // ── Link para cadastro ────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Não possui conta? ', style: AppTextStyles.bodyMedium),
                    GestureDetector(
                      onTap: () => context.go('/register'),
                      child: Text('Cadastre-se',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primary,
                          )),
                    ),
                  ],
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

/// Widget da logo "El@s CONECTADAS" com símbolo feminino
class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'El@s',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.female, color: AppColors.primary, size: 22),
            Text(
              'CONECTADAS',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
