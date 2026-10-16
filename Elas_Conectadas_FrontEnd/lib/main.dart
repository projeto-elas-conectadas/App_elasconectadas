import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/routes/deep_link.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ElasConectadasApp());
}

class ElasConectadasApp extends StatefulWidget {
  const ElasConectadasApp({super.key});

  @override
  State<ElasConectadasApp> createState() => _ElasConectadasAppState();
}

class _ElasConectadasAppState extends State<ElasConectadasApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _listenToIncomingLinks();
  }

  /// Escuta o link que abriu o app e os links que chegam com ele já aberto.
  Future<void> _listenToIncomingLinks() async {
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _openFromLink(initialLink);
      }
    } catch (_) {
      // Desktop/web sem o plugin nativo: o app segue na rota inicial.
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      _openFromLink,
      onError: (_) {},
    );
  }

  void _openFromLink(Uri uri) {
    final location = locationForDeepLink(uri);
    if (location == null) return;
    appRouter.go(location);
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Elas Conectadas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
