import 'package:openapi/openapi.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final Openapi _instance = Openapi(
    basePathOverride: 'http://localhost:8080', // ou a URL do ngrok
    interceptors: [
      // Aqui você pode adicionar o interceptor de JWT
    ],
  );

  static UsersApi get users => _instance.getUsersApi();
  static AuthApi get auth => _instance.getAuthApi();
  static PostsApi get posts => _instance.getPostsApi();
  static AdsApi get ads => _instance.getAdsApi();
  static ProdutosApi get produtos => _instance.getProdutosApi();
  static UploadsApi get uploads => _instance.getUploadsApi();
}
