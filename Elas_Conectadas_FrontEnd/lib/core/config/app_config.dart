import 'package:flutter/foundation.dart';

class AppConfig {
  AppConfig._();

  static String get apiUrl {
    // if (kIsWeb) {
    //   return 'https://orion-nonpsychologic-cara.ngrok-free.dev';
    // }
    // // Substitua pelo IP da sua máquina na rede para testar em dispositivo físico
    // return 'https://orion-nonpsychologic-cara.ngrok-free.dev';
    // Para desenvolvimento local, aponte para o backend rodando na sua máquina
    return 'http://localhost:8080';
    
    // Para testes com ngrok (descomente e atualize quando necessário):
    // return 'https://orion-nonpsychologic-cara.ngrok-free.dev';
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
