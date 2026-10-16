

class AppConfig {
  AppConfig._();

  /// Servidor público (ping de elasconectadas.labcct.net.br).
  /// O mesmo host está no intent-filter do AndroidManifest.
  static const String apiHost = 'elasconectadas.labcct.net.br';
  static const String serverIp = '200.201.11.8';

  /// Porta em que o Nest escuta (`app.listen(8080)`).
  static const int apiPort = 8080;

  static String get apiUrl => 'http://$apiHost:$apiPort';

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
