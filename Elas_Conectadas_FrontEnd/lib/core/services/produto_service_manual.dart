import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/produto_model.dart';
import '../services/auth_service.dart';

/// Serviço para operações de Produto/Serviço no backend.
class ProdutoService {
  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthService.getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // ── Criar produto/serviço ────────────────────────────────────────────────────
  /// [imagemBytes] são os bytes da imagem selecionada pelo usuário (opcional).
  /// Serão enviados para o Cloudinary via backend, que retornará a URL.
  static Future<ProdutoModel> criar({
    required String nome,
    required String descricao,
    required double preco,
    required String categoria, // 'PRODUCT' ou 'SERVICE'
    required String userId,
    Uint8List? imagemBytes,
  }) async {
    String? imagemUrl;

    // 🚀 PASSO 1: O Upload da Imagem para o Cloudinary (via NestJS)
    if (imagemBytes != null) {
      final uploadUrl = Uri.parse('${AppConfig.apiUrl}/upload/imagem');
      
      var request = http.MultipartRequest('POST', uploadUrl);
      
      // Enviamos o token caso a sua rota de upload exija estar logado
      final token = await AuthService.getToken();
      request.headers['Authorization'] = 'Bearer $token';

      // Anexamos a imagem na requisição ('file' é o nome que o NestJS espera)
      request.files.add(
        http.MultipartFile.fromBytes(
          'file', 
          imagemBytes,
          filename: 'upload.jpg', // Nome genérico
        ),
      );

      // Enviamos e aguardamos a resposta
      final streamedResponse = await request.send().timeout(const Duration(seconds: 15));
      final uploadResponse = await http.Response.fromStream(streamedResponse);

      if (uploadResponse.statusCode == 200 || uploadResponse.statusCode == 201) {
        final responseData = jsonDecode(uploadResponse.body);
        // Pegamos o link levinho que o servidor devolveu!
        imagemUrl = responseData['imageUrl']; 
      } else {
        throw Exception('Erro ao fazer upload da imagem: ${uploadResponse.statusCode}');
      }
    }

    // 🚀 PASSO 2: Criar o Produto no Banco de Dados
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.produtosEndpoint}');

    final body = ProdutoModel(
      nome: nome,
      descricao: descricao,
      preco: preco,
      categoria: categoria,
      imagemUrl: imagemUrl, // Aqui vai o link do Cloudinary (ou null)
      userId: userId,
    ).toJson();

    final response = await http.post(
      url,
      headers: await _authHeaders(),
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProdutoModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    final msg = _extractError(response.body);
    throw Exception(msg);
  }

  // ── Listar todos ────────────────────────────────────────────────────────────
  static Future<List<ProdutoModel>> listar() async {
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.produtosEndpoint}');
    final response = await http.get(url).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => ProdutoModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Erro ao carregar produtos');
  }

  // ── Deletar ──────────────────────────────────────────────────────────────────
  static Future<void> deletar(String id) async {
    final url = Uri.parse('${AppConfig.apiUrl}${AppConfig.produtosEndpoint}/$id');
    await http.delete(url, headers: await _authHeaders())
        .timeout(const Duration(seconds: 10));
  }

  static String _extractError(String body) {
    try {
      final parsed = jsonDecode(body) as Map<String, dynamic>;
      final msg = parsed['message'];
      return msg is List ? msg.join(', ') : msg?.toString() ?? 'Erro desconhecido';
    } catch (_) {
      return 'Erro ao processar resposta do servidor';
    }
  }
}