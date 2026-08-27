import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'api_client.dart';

/// Serviço de autenticação — usando código gerado pelo contrato OpenAPI.
/// Comparação com a versão manual: veja auth_service_manual.dart
class AuthService {
  static const _tokenKey = 'jwt_token';
  static const _userKey = 'user_data';

  static Future<T> _execute<T>(
    Future<T> Function() request, {
    required String fallbackMessage,
  }) async {
    try {
      return await request();
    } on AuthException {
      rethrow;
    } on DioException catch (error) {
      throw AuthException(
        _dioMessage(error, fallbackMessage),
        statusCode: error.response?.statusCode,
      );
    } catch (_) {
      throw AuthException(fallbackMessage);
    }
  }

  static String _dioMessage(DioException error, String fallbackMessage) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return 'O servidor demorou para responder. Tente novamente em instantes.';
      case DioExceptionType.connectionError:
        return 'Não foi possível conectar ao servidor. Verifique se o backend está em execução.';
      case DioExceptionType.cancel:
        return 'A operação foi cancelada.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _responseMessage(error.response?.data);
        if (message != null && message.isNotEmpty) return message;
        if (statusCode != null && statusCode >= 500) {
          return 'Ocorreu um erro no servidor. Tente novamente em instantes.';
        }
        return fallbackMessage;
      case DioExceptionType.badCertificate:
        return 'Não foi possível validar a conexão segura com o servidor.';
      case DioExceptionType.unknown:
        return fallbackMessage;
    }
  }

  static String? _responseMessage(dynamic data) {
    if (data is! Map) return null;
    final message = data['message'];
    if (message is List) {
      return message.map((item) => item.toString()).join(', ');
    }
    return message?.toString();
  }

  // ─── Token (persistência local) ────────────────────────────────────────────

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

  // ─── Login (via cliente gerado) ────────────────────────────────────────────

  /// Faz login e retorna o token JWT.
  /// Usa o DTO gerado [LoginDto] e recebe [LoginResponseDto].
  static Future<String> login(String email, String password) async {
    final response = await _execute(
      () => ApiClient.auth.authControllerLogin(
        loginDto: LoginDto((b) => b
          ..email = email
          ..password = password),
      ),
      fallbackMessage: 'Não foi possível fazer login.',
    );

    final data = response.data;
    final token = data?.accessToken;

    if (token != null && token.isNotEmpty) {
      await saveToken(token);

      // Salva dados básicos do usuário localmente
      if (data?.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userKey, jsonEncode(data!.user!.value));
      }
      return token;
    }

    throw Exception('Erro ao fazer login — token não recebido');
  }

  // ─── Registro (via cliente gerado) ─────────────────────────────────────────

  /// Registra uma nova usuária usando o DTO gerado [CreateUserDto].
  static Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String dob,
  }) async {
    await _execute(
      () => ApiClient.users.usersControllerCreateUser(
        createUserDto: CreateUserDto((b) => b
          ..email = email
          ..password = password
          ..name = name
          ..phone = phone
          ..dob = dob),
      ),
      fallbackMessage: 'Não foi possível realizar o cadastro.',
    );
  }

  // ─── OTP (via cliente gerado) ──────────────────────────────────────────────

  /// Solicita um código OTP usando o DTO gerado [RequestTokenDto].
  static Future<void> requestOtp(String email) async {
    await _execute(
      () => ApiClient.auth.authControllerRequestOTP(
        requestTokenDto: RequestTokenDto((b) => b..email = email),
      ),
      fallbackMessage: 'Não foi possível reenviar o código.',
    );
  }

  /// Verifica o código OTP usando o DTO gerado [VerifyOtpDto].
  static Future<void> verifyOtp(String email, String otp) async {
    await _execute(
      () => ApiClient.auth.authControllerVerifyOTP(
        verifyOtpDto: VerifyOtpDto((b) => b
          ..email = email
          ..otp = otp),
      ),
      fallbackMessage: 'Não foi possível verificar o código.',
    );
  }

  // ─── Perfil (via cliente gerado) ───────────────────────────────────────────

  /// Busca o perfil da usuária logada.
  /// Nota: usa o Dio do ApiClient diretamente pois o endpoint /users/me
  /// não está na spec OpenAPI (o backend pode expô-lo futuramente).
  static Future<UserModel> getProfile() async {
    final token = await getToken();
    // Usa o Dio interno do ApiClient para manter o mesmo base URL
    final response = await ApiClient.dio.get(
      '/users/me',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception('Falha ao buscar perfil');
  }
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  const AuthException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
