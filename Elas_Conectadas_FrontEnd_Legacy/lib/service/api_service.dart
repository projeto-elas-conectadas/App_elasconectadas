import 'dart:convert';

import 'package:conectadas_app/models/login_request_model.dart';
import 'package:conectadas_app/models/login_response_model.dart';
import 'package:conectadas_app/models/register_request_model.dart';
import 'package:conectadas_app/models/register_response_model.dart';
import 'package:conectadas_app/service/shared_service.dart';
import 'package:conectadas_app/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// A classe APIService é usada para centralizar as chamadas HTTP.
class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model, {String? otp}) async {
    Map<String, String> requestHeaders = {
      // Cria o cabeçalho da requisição informando ao servidor que o seu corpo (body) será JSON
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> body = {
      'email': model.email,
      'password': model.password
    };
    if (otp != null) {
      body['otp'] = otp;
    }

    // Cria uma url ao unir Config.apiURL (domínio e porta) e Config.loginAPI (caminho/endpoint)
    // Ex: https://10.0.2.2:8080/auth/login
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    try {
      // Realiza uma requisição POST com os campos da requisição Json mapeados para propriedades de um
      // objeto LoginRequestModel
      var response = await client
          .post(url, headers: requestHeaders, body: jsonEncode(model.toJson()))
          .timeout(const Duration(seconds: 10));

      // Retorna true ou false a depender do status da resposta
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data.containsKey('access_token')) {
          // Coverte a resposta em um LoginResponseModel
          final loginResponse = LoginResponseModel.fromJson(data);
          // Salva o token e dados do usuário em cache
          await SharedService.setLoginDetails(loginResponse);
          return true;
        } else {
          print('⚠️ Resposta 200, mas sem access_token no corpo.');
          return false;
        }
      } else if (response.statusCode == 401) {
        print('❌ Credenciais inválidas.');
        return false;
      } else {
        print('Erro inesperado: ${response.statusCode}');
        return false;
      }
    } on FormatException {
      print('⚠️ Erro ao decodificar resposta JSON.');
      return false;
    } catch (e) {
      print('❌ Falha de conexão com o servidor ou erro: $e');
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);
    
    try {
      var response = await client
          .post(
            url,
            headers: requestHeaders,
            body: jsonEncode(model.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Cadastro bem-sucedido
        //print("Registro realizado com sucesso!");
        return registerResponseModel(response.body);
      } else {
        // Erro retornado pela API
        //print(
        //    "Falha ao registrar. Status: ${response.statusCode}, Corpo: ${response.body}");
        return registerResponseModel(response.body);
      }
    } catch (e) {
      return RegisterResponseModel(
        id: null,
        message: "Falha na conexão ou erro: $e",
      );
    } catch (e) {
      //print("Erro inesperado no registro: $e");
      return RegisterResponseModel(
        id: null,
        message: "Erro inesperado: $e",
      );
    }
  }

  static Future<bool> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    print(loginDetails);

    // Se não houver token salvo, não está logado
    if (loginDetails == null || loginDetails.accessToken == null) {
      return false;
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails.accessToken}', 
    };

    var url = Uri.http(Config.apiURL, "/users/${loginDetails.user?.id ?? ''}");
    print(url);

    try {
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200) {
        print("✅ Token válido — usuário autenticado.");
        return true;
      } else if (response.statusCode == 401) {
        print("❌ Token inválido ou expirado.");
        await SharedService.logout();
        return false;
      } else {
        print("⚠️ Erro inesperado ao verificar token: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🚨 Erro de conexão: $e");
      return false;
    }
  }

  static Future<Map<String, dynamic>> requestOtp(String email) async {
  final response = await http.post(
    Uri.http(Config.apiURL, Config.requestOTP),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Falha ao reenviar código');
  }
}

static Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {

  final response = await http.post(
    Uri.http(Config.apiURL, Config.verifyOTP),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'otp': otp}),
  );

  print('Status code: ${response.statusCode}');
  print('Body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Falha ao verificar OTP');
  }
}

}
