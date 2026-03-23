import 'dart:convert';

import 'package:conectadas_app/models/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe utilizada para gerenciar informações de login armazenadas localmente.
// Substituída de api_cache_manager (sqflite, não suporta web) para shared_preferences.
class SharedService {

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("login_details");
  }

  static Future<LoginResponseModel?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("login_details");
    if (data != null) {
      return loginResponseJson(data);
    }
    return null;
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("login_details", jsonEncode(model.toJson()));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("login_details");
  }

  static Future<void> logoutAndRedirect(BuildContext context) async {
    await logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }
}