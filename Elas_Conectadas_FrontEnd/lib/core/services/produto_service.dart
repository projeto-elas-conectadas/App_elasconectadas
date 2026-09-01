import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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
    required List<ImagemUpload> imagens,
    required String regiaoAtendimento,
  }) async {
    return _execute(
      () async {
        if (imagens.isEmpty) {
          throw const ProdutoException(
            'Adicione ao menos uma foto para publicar o anúncio.',
          );
        }

        final imageUrls = <String>[];
        for (final imagem in imagens) {
          final formData = FormData();
          formData.files.add(
            MapEntry<String, MultipartFile>(
              'file',
              await _toMultipartFile(imagem),
            ),
          );
          final imageUrl = await ApiClient.uploadImagem(formData);
          imageUrls.add(imageUrl);
        }

        final response = await ApiClient.produtos.produtosCreate(
          createProdutoDto: CreateProdutoDto((b) => b
            ..nome = nome
            ..descricao = descricao
            ..preco = preco
            ..categoria = categoria
            ..userId = userId
            ..imagemPrincipal = imageUrls.first
            ..regiaoAtendimento = regiaoAtendimento
            ..imagensAdicionais = imageUrls.length > 1
                ? ListBuilder<String>(imageUrls.skip(1))
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

  static Future<MultipartFile> _toMultipartFile(ImagemUpload imagem) async {
    if (imagem.bytes.isEmpty) {
      throw const ProdutoException('Uma das fotos selecionadas está vazia.');
    }

    final filename = imagem.nome.trim().isEmpty ? 'upload.jpg' : imagem.nome;
    final contentType = _mediaTypeFor(filename);

    if (imagem.temArquivoLocal) {
      return MultipartFile.fromFile(
        imagem.path!,
        filename: filename,
        contentType: contentType,
      );
    }

    return MultipartFile.fromBytes(
      imagem.bytes,
      filename: filename,
      contentType: contentType,
    );
  }

  static MediaType _mediaTypeFor(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return MediaType('image', 'png');
      case 'webp':
        return MediaType('image', 'webp');
      case 'gif':
        return MediaType('image', 'gif');
      case 'heic':
      case 'heif':
        return MediaType('image', 'heic');
      default:
        return MediaType('image', 'jpeg');
    }
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

class ImagemUpload {
  final Uint8List bytes;
  final String nome;
  final String? path;

  const ImagemUpload({
    required this.bytes,
    required this.nome,
    this.path,
  });

  bool get temArquivoLocal {
    final filePath = path;
    if (filePath == null || filePath.isEmpty) return false;
    return !filePath.startsWith('blob:') && !filePath.startsWith('http');
  }
}

class ProdutoException implements Exception {
  final String message;

  const ProdutoException(this.message);

  @override
  String toString() => message;
}
