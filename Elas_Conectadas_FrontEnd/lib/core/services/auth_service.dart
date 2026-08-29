import 'dart:convert';
import 'dart:typed_data';

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

      // Mantém localmente os dados tipados descritos no contrato.
      if (data?.user != null) {
        final user = UserModel.fromDto(data!.user!);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userKey, jsonEncode(user.toJson()));
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
    Uint8List? profileImageBytes,
    String profileImageName = 'perfil.jpg',
  }) async {
    String? profileImageUrl;
    if (profileImageBytes != null) {
      final uploadResponse = await _execute(
        () => ApiClient.uploads.uploadControllerUploadImagem(
          file: MultipartFile.fromBytes(
            profileImageBytes,
            filename: profileImageName,
          ),
        ),
        fallbackMessage: 'Não foi possível enviar a foto do cadastro.',
      );
      profileImageUrl = uploadResponse.data?.imageUrl;
      if (profileImageUrl == null || profileImageUrl.isEmpty) {
        throw const AuthException(
          'O servidor não retornou a URL da foto enviada.',
        );
      }
    }

    await _execute(
      () => ApiClient.users.usersControllerCreateUser(
        createUserDto: CreateUserDto((b) => b
          ..email = email
          ..password = password
          ..name = name
          ..phone = phone
          ..dob = dob
          ..pfp = profileImageUrl),
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

  // ─── Usuária da sessão ─────────────────────────────────────────────────────

  /// Retorna os dados recebidos no login e persistidos no dispositivo.
  /// O backend atual ainda não expõe uma rota `/users/me` no contrato.
  static Future<UserModel?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUser = prefs.getString(_userKey);
    if (savedUser == null || savedUser.isEmpty) return null;

    try {
      return UserModel.fromJson(
        jsonDecode(savedUser) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  const AuthException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
