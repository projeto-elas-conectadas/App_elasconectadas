import 'package:openapi/openapi.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiUrl,
      connectTimeout: const Duration(seconds: 10),
      // Uploads de imagem podem levar mais tempo que requisições JSON.
      sendTimeout: const Duration(seconds: 30),
      // Cadastro e reenvio de OTP aguardam a resposta do provedor de e-mail.
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  static final Openapi _instance = Openapi(
    dio: _dio,
    interceptors: [
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('jwt_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    ],
  );

  static UsersApi get users => _instance.getUsersApi();
  static AuthApi get auth => _instance.getAuthApi();
  static PostsApi get posts => _instance.getPostsApi();
  static AdsApi get ads => _instance.getAdsApi();
  static ProdutosApi get produtos => _instance.getProdutosApi();
  static UploadsApi get uploads => _instance.getUploadsApi();

  /// Acesso direto ao Dio para endpoints que não estão na spec OpenAPI.
  /// Exemplo: /users/me (perfil da usuária logada).
  static Dio get dio => _instance.dio;
}
