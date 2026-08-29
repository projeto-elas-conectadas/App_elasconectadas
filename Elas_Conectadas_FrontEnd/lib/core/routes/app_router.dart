import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/auth/otp_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/mural/mural_screen.dart';
import '../../features/ads/create_ad_screen.dart';
import '../services/auth_service.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async {
    final isLoggedIn = await AuthService.isLoggedIn();
    final isAuthRoute = state.matchedLocation.startsWith('/login') ||
        state.matchedLocation.startsWith('/register') ||
        state.matchedLocation.startsWith('/otp');
    if (!isLoggedIn && !isAuthRoute) return '/login';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final email = state.extra as String;
        return OtpScreen(email: email);
      },
    ),
    GoRoute(
      path: '/criar-anuncio',
      builder: (context, state) => const CreateAdScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/mural',
          builder: (context, state) => const MuralScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

/// Shell com NavBar que contém Home, Mural e Perfil
class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _routes = ['/home', '/mural', '/profile'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _routes.indexWhere(
      (route) => location == route || location.startsWith('$route/'),
    );

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        onDestinationSelected: (index) {
          context.go(_routes[index]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Mural',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
