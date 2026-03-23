import 'package:conectadas_app/models/login_request_model.dart';
import 'package:conectadas_app/pages/auth/register.dart';
import 'package:conectadas_app/pages/home_page.dart';
import 'package:conectadas_app/service/api_service.dart';
import 'package:conectadas_app/service/shared_service.dart';
import 'package:conectadas_app/widgets/auth/custom_textfield.dart';
import 'package:conectadas_app/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  bool isLoading = false;

  bool validateFields() {
    final form = globalFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _showAlertDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final model = LoginRequestModel(email: email, password: password);
    setState(() => isLoading = true);

    if (!validateFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos!')),
      );
      setState(() => isLoading = false);
      return;
    }

    try {
      final success = await APIService.login(model);

      if (success) {
        var isLoggedIn = await SharedService.isLoggedIn();
        if (isLoggedIn) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          _showAlertDialog(
            title: "Falha no login",
            message: "Usuário ou senha inválidos ou servidor offline",
          );
        }
      } else {
        _showAlertDialog(
          title: "Falha no login",
          message: "Usuário ou senha inválidos. Verifique se o servidor está rodando.",
        );
      }
    } catch (e) {
      _showAlertDialog(
        title: "Erro inesperado",
        message: "$e",
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage("assets/images/elas.png")),
                const SizedBox(height: 30.0),
                CustomTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  obscureText: false,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'O campo e-mail é obrigatório' : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Senha',
                  obscureText: isPasswordVisible,
                  isPassword: true,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'O campo senha é obrigatório' : null,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: isPasswordVisible
                        ? const Icon(Icons.visibility_off_outlined, size: 20, color: Color(0xFF9146FF))
                        : const Icon(Icons.visibility, size: 20, color: Color(0xFF9146FF)),
                    onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Entrar',
                        onPressed: handleLogin,
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap != null ? () => widget.onTap!() : null,
                      child: const Text(
                        'Esqueceu a senha?!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não possui uma conta?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Faça seu cadastro',
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
