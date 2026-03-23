// O arquivo config.dart é responsável por centralizar as configurações do sistema, agrupando em um só lugar
// URLs, chaves ou nomes de apps. Ao invés de você descrever essas informações a cada uso você simplesmente
// faz uso das suas propriedades, tornando mais fácil a alteração.
import 'package:flutter/foundation.dart';

class Config {
  static const String appName = "El@s conectadas";

  /// Retorna o endereço correto do backend dependendo da plataforma
  static String get apiURL {
    if (kIsWeb) {
      // Rodando no browser (Edge, Chrome) - acessa localhost diretamente
      return "localhost:8080";
    }
    // Para mobile (Android/iOS físico), substitua pelo IP real da sua máquina na rede
    return "192.168.0.41:8080";
  }

  /// Endpoints da API
  static const String loginAPI = "/auth/login";
  static const String registerAPI = "/users/register";
  static const String userProfileAPI = "/users";
  static const String requestOTP = '/auth/request-otp';
  static const String verifyOTP = '/auth/verify-otp';
}