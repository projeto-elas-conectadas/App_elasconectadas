import '../config/app_config.dart';

/// Traduz um link do servidor público para uma rota do GoRouter.
///
/// Só reage a `elasconectadas.labcct.net.br` ou ao IP `200.201.11.8`
/// (e a caminhos sem host, já dentro do app).
/// `/login` abre o login. `/produtos` abre a lista (Home).
/// `/produtos/{id}` abre o detalhe do produto.
String? locationForDeepLink(Uri uri) {
  if (!_isServerLink(uri)) return null;

  final segments = uri.pathSegments.where((segment) => segment.isNotEmpty).toList();
  if (segments.isEmpty) return null;

  switch (segments.first) {
    case 'login':
      return '/login';
    case 'produtos':
      if (segments.length >= 2 && segments[1].isNotEmpty) {
        return '/produto/${segments[1]}';
      }
      return '/home';
    default:
      return null;
  }
}

bool _isServerLink(Uri uri) {
  if (uri.host.isEmpty) return true;
  final host = uri.host.toLowerCase();
  return host == AppConfig.apiHost || host == AppConfig.serverIp;
}
