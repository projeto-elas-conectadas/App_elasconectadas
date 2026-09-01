import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  Uint8List? _profileImageBytes;
  String _profileImageName = 'perfil.jpg';
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    if (!mounted) return;
    setState(() {
      _profileImageBytes = bytes;
      _profileImageName = picked.name;
    });
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await AuthService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        dob: _dobController.text.trim(),
        profileImageBytes: _profileImageBytes,
        profileImageName: _profileImageName,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado! Verifique seu e-mail.'),
            backgroundColor: AppColors.success,
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) context.go('/otp', extra: _emailController.text.trim());
      }
    } catch (e) {
      if (mounted) {
        if (e is AuthException &&
            e.statusCode == 400 &&
            e.message.toLowerCase().contains('já está cadastrado')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta já cadastrada. Informe o código enviado.'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go('/otp', extra: _emailController.text.trim());
          return;
        }

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.go('/login'),
        ),
        title: Text('Criar conta',
            style: AppTextStyles.titleLarge.copyWith(color: AppColors.primary)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Foto de perfil', style: AppTextStyles.titleMedium),
                const SizedBox(height: 10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: _isLoading ? null : _pickProfileImage,
                      borderRadius: BorderRadius.circular(56),
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: AppColors.primaryLight,
                        backgroundImage: _profileImageBytes == null
                            ? null
                            : MemoryImage(_profileImageBytes!),
                        child: _profileImageBytes == null
                            ? const Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.primary,
                                size: 34,
                              )
                            : null,
                      ),
                    ),
                    if (_profileImageBytes != null)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: IconButton.filled(
                          tooltip: 'Remover foto',
                          onPressed: _isLoading
                              ? null
                              : () => setState(() {
                                    _profileImageBytes = null;
                                    _profileImageName = 'perfil.jpg';
                                  }),
                          icon: const Icon(Icons.close, size: 18),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _profileImageBytes == null
                      ? 'Toque para escolher uma foto (opcional)'
                      : 'Toque na foto para trocar',
                  style: AppTextStyles.labelMedium,
                ),
                const SizedBox(height: 22),
                CustomInput(
                  controller: _nameController,
                  label: 'Nome completo',
                  hint: 'Seu nome',
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Informe seu nome'
                      : null,
                ),
                const SizedBox(height: 14),
                CustomInput(
                  controller: _emailController,
                  label: 'E-mail',
                  hint: 'seu@email.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    final email = v?.trim() ?? '';
                    if (email.isEmpty) return 'Informe seu e-mail';
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                CustomInput(
                  controller: _passwordController,
                  label: 'Senha',
                  hint: 'Mínimo 6 caracteres',
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
                const SizedBox(height: 14),
                CustomInput(
                  controller: _phoneController,
                  label: 'Celular',
                  hint: '(11) 99999-9999',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _PhoneFormatter()
                  ],
                  validator: (v) {
                    final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                    if (digits.length < 10 || digits.length > 11) {
                      return 'Informe um celular válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                CustomInput(
                  controller: _dobController,
                  label: 'Data de Nascimento',
                  hint: 'DD/MM/AAAA',
                  prefixIcon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _DateFormatter()
                  ],
                  validator: (v) {
                    final dob = v?.trim() ?? '';
                    if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(dob)) {
                      return 'Use o formato DD/MM/AAAA';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                CustomButton(
                  text: 'Criar conta',
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Já tem conta? ', style: AppTextStyles.bodyMedium),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text('Faça o login!',
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

// ─── Formatadores ────────────────────────────────────────────────────────────

class _PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length && i < 11; i++) {
      if (i == 0) buffer.write('(');
      if (i == 2) buffer.write(') ');
      if (i == 7) buffer.write('-');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length && i < 8; i++) {
      if (i == 2 || i == 4) buffer.write('/');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
