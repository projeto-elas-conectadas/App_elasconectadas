import 'package:elasconectadas_app/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a API de produção usa o domínio HTTPS', () {
    expect(AppConfig.apiUrl, 'https://elasconectadas.labcct.net.br');
    expect(AppConfig.apiHost, 'elasconectadas.labcct.net.br');
    expect(Uri.parse(AppConfig.apiUrl).scheme, 'https');
    expect(Uri.parse(AppConfig.apiUrl).hasPort, isFalse);
  });
}
