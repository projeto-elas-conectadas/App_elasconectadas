import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:openapi/openapi.dart';

import '../models/produto_model.dart';
import 'api_client.dart';

/// Serviço de Produtos — agora usando código gerado pelo contrato OpenAPI.
/// Comparação com a versão manual: veja produto_service_manual.dart
class ProdutoService {
  static Future<T> _execute<T>(
    Future<T> Function() request, {
    required String fallbackMessage,
  }) async {
    try {
      return await request();
    } on ProdutoException {
      rethrow;
    } on DioException catch (error) {
      throw ProdutoException(_dioMessage(error, fallbackMessage));
    } catch (_) {
      throw ProdutoException(fallbackMessage);
    }
  }

  // ── Criar produto/serviço ──────────────────────────────────────────────
  static Future<ProdutoModel> criar({
    required String nome,
    required String descricao,
    required String preco,
    required String categoria,
    required String userId,
    required Uint8List imagemBytes,
    required String regiaoAtendimento,
    String imagemNome = 'upload.jpg',
    List<String>? imagensAdicionais,
  }) async {
    return _execute(
      () async {
        // 1. Envia os bytes ao endpoint tipado de upload.
        final uploadResponse =
            await ApiClient.uploads.uploadControllerUploadImagem(
          file: MultipartFile.fromBytes(imagemBytes, filename: imagemNome),
        );
        final imagemPrincipal = uploadResponse.data?.imageUrl;
        if (imagemPrincipal == null || imagemPrincipal.isEmpty) {
          throw const ProdutoException(
            'O servidor não retornou a URL da imagem enviada.',
          );
        }

        // 2. Usa a URL retornada para montar o DTO definido no contrato.
        final response = await ApiClient.produtos.produtosCreate(
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
                : null),
        );
        final produto = response.data;
        if (produto == null) {
          throw const ProdutoException(
            'O servidor não retornou o produto cadastrado.',
          );
        }
        return ProdutoModel.fromDto(produto);
      },
      fallbackMessage: 'Não foi possível cadastrar o anúncio.',
    );
  }

  // ── Listar todos ───────────────────────────────────────────────────────
  static Future<List<ProdutoModel>> listar() async {
    return _execute(
      () async {
        final response = await ApiClient.produtos.produtosFindAll();
        return response.data
                ?.map(ProdutoModel.fromDto)
                .toList(growable: false) ??
            const [];
      },
      fallbackMessage: 'Não foi possível carregar os produtos.',
    );
  }

  // ── Buscar por ID ──────────────────────────────────────────────────────
  static Future<ProdutoModel> buscarPorId(String id) async {
    return _execute(
      () async {
        final response = await ApiClient.produtos.produtosFindOne(id: id);
        final produto = response.data;
        if (produto == null) {
          throw const ProdutoException('Produto não encontrado.');
        }
        return ProdutoModel.fromDto(produto);
      },
      fallbackMessage: 'Não foi possível carregar o produto.',
    );
  }

  static String _dioMessage(DioException error, String fallbackMessage) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return 'O servidor demorou para responder. Tente novamente.';
      case DioExceptionType.connectionError:
        return 'Não foi possível conectar ao servidor.';
      case DioExceptionType.badResponse:
        final message = _responseMessage(error.response?.data);
        if (message != null && message.isNotEmpty) return message;
        return fallbackMessage;
      case DioExceptionType.cancel:
        return 'A operação foi cancelada.';
      case DioExceptionType.badCertificate:
        return 'Não foi possível validar a conexão segura.';
      case DioExceptionType.unknown:
        return fallbackMessage;
    }
  }

  static String? _responseMessage(dynamic data) {
    if (data is! Map) return null;
    final message = data['message'];
    if (message is List) {
      return message.map((item) => item.toString()).join(', ');
    }
    return message?.toString();
  }
}

class ProdutoException implements Exception {
  final String message;

  const ProdutoException(this.message);

  @override
  String toString() => message;
}
