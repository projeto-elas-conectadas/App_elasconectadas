import 'package:conectadas_app/pages/auth/login.dart';
import 'package:conectadas_app/pages/auth/verifyOtp.dart';
import 'package:conectadas_app/pages/home_page.dart';
import 'package:conectadas_app/pages/posts/adm/create_posts.dart';
import 'package:conectadas_app/pages/posts/adm/posts_list_page.dart';
import 'package:conectadas_app/pages/posts/user/create_ads.dart';
import 'package:conectadas_app/pages/profile/user_profile.dart';
import 'package:conectadas_app/service/login_or_register.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/auth': (context) => const LoginOrRegister(),
    '/login': (context) => const LoginPage(),
    '/profile': (context) => const UserPage(),
    '/home': (context) => const HomePage(),
    '/posts': (context) => const PostsListPage(),
    '/createads': (context) => const AdCreationPage(),
    '/createpost': (context) => const PostCreationPage(),
    // Rota de verificação OTP — o email é passado como argumento
    '/verifyotp': (context) {
      final email = ModalRoute.of(context)!.settings.arguments as String;
      return VerifyOtp(email: email);
    },
  };
}
