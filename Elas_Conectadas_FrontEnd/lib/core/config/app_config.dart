

class AppConfig {
  AppConfig._();

  static String get apiUrl {
    // Túnel Cloudflare do backend (APK / dispositivo físico)
    return 'https://deputy-nation-but-queries.trycloudflare.com';

    // Desenvolvimento local (descomente e comente o túnel acima):
    // return 'http://localhost:8080';
  }

  // Endpoints de autenticação
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/users/register';
  static const String requestOtpEndpoint = '/auth/request-otp';
  static const String verifyOtpEndpoint = '/auth/verify-otp';

  // Endpoints de perfil
  static const String userProfileEndpoint = '/users';

  // Endpoints de anúncios
  static const String adsEndpoint = '/ads';

  // Endpoints de posts (mural)
  static const String postsEndpoint = '/posts';

  // Endpoint de produtos/serviços
  static const String produtosEndpoint = '/produtos';
}
