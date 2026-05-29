import 'package:built_collection/built_collection.dart';
import 'package:openapi/openapi.dart';
import 'api_client.dart';

/// Serviço de Produtos — agora usando código gerado pelo contrato OpenAPI.
/// Comparação com a versão manual: veja produto_service_manual.dart
class ProdutoService {

  // ── Criar produto/serviço ──────────────────────────────────────────────
  static Future<void> criar({
    required String nome,
    required String descricao,
    required String preco,
    required String categoria,
    required String userId,
    required String imagemPrincipal,
    required String regiaoAtendimento,
    List<String>? imagensAdicionais,
  }) async {
    await ApiClient.produtos.produtosCreate(
      createProdutoDto: CreateProdutoDto((b) => b
        ..nome = nome
        ..descricao = descricao
        ..preco = preco
        ..categoria = categoria
        ..userId = userId
        ..imagemPrincipal = imagemPrincipal
        ..regiaoAtendimento = regiaoAtendimento
        ..imagensAdicionais = imagensAdicionais != null
            ? ListBuilder<String>(imagensAdicionais)
            : null
      ),
    );
  }

  // ── Listar todos ───────────────────────────────────────────────────────
  static Future<dynamic> listar() async {
    final response = await ApiClient.produtos.produtosFindAll();
    return response.data;
  }

  // ── Buscar por ID ──────────────────────────────────────────────────────
  static Future<dynamic> buscarPorId(String id) async {
    final response = await ApiClient.produtos.produtosFindOne(id: id);
    return response.data;
  }
}
