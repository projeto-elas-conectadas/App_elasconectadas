import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../models/user_model.dart';

/// Serviço de autenticação — todas as chamadas de auth ao backend
class AuthService {
  static const _tokenKey = 'jwt_token';
  static const _userKey = 'user_data';

  // ─── Token ──────────────────────────────────────────────────────────────────

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }

  // ─── Login ───────────────────────────────────────────────────────────────────

  /// Retorna o token em caso de sucesso, ou lança uma Exception com a mensagem de erro
  static Future<String> login(String email, String password) async {
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.loginEndpoint}');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'ngrok-skip-browser-warning': 'true' // <--- CRACHÁ DO NGROK AQUI
      },
      body: jsonEncode({'email': email, 'password': password}),
    ).timeout(const Duration(seconds: 10));

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Backend retorna { access_token, user }
      final token = body['access_token'] as String?;
      if (token != null) {
        await saveToken(token);
        // Salva dados básicos do usuário localmente
        if (body['user'] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_userKey, jsonEncode(body['user']));
        }
        return token;
      }
    }

    final msg = body['message'] is List
        ? (body['message'] as List).join(', ')
        : body['message']?.toString() ?? 'Erro ao fazer login';
    throw Exception(msg);
  }

  // ─── Registro ───────────────────────────────────────────────────────────────

  /// Retorna o UserModel criado, ou lança Exception com mensagem de erro
  static Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String dob,
  }) async {
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.registerEndpoint}');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'ngrok-skip-browser-warning': 'true' // <--- CRACHÁ DO NGROK AQUI
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'dob': dob,
      }),
    ).timeout(const Duration(seconds: 10));

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if ((response.statusCode == 200 || response.statusCode == 201) && body['id'] != null) {
      return UserModel.fromJson(body);
    }

    final msg = body['message'] is List
        ? (body['message'] as List).join(', ')
        : body['message']?.toString() ?? 'Erro ao registrar';
    throw Exception(msg);
  }

  // ─── OTP ────────────────────────────────────────────────────────────────────

  static Future<void> requestOtp(String email) async {
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.requestOtpEndpoint}');
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'ngrok-skip-browser-warning': 'true' // <--- CRACHÁ DO NGROK AQUI
      },
      body: jsonEncode({'email': email}),
    ).timeout(const Duration(seconds: 10));
  }

  static Future<void> verifyOtp(String email, String otp) async {
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.verifyOtpEndpoint}');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'ngrok-skip-browser-warning': 'true' // <--- CRACHÁ DO NGROK AQUI
      },
      body: jsonEncode({'email': email, 'otp': otp}),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200 && response.statusCode != 201) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final msg = body['message']?.toString() ?? 'Código inválido';
      throw Exception(msg);
    }
  }

  // ─── Perfil ──────────────────────────────────────────────────────────────────

  static Future<UserModel> getProfile() async {
    final token = await getToken();
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.userProfileEndpoint}/me');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        // 'ngrok-skip-browser-warning': 'true' // <--- CRACHÁ DO NGROK AQUI
      },
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Falha ao buscar perfil');
  }
}