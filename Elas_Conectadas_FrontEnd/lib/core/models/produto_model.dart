import 'package:openapi/openapi.dart';

/// Modelo de apresentação de Produto/Serviço.
///
/// Os dados de integração chegam tipados como [ProdutoResponseDto] pelo cliente
/// gerado. Este modelo mantém a interface desacoplada dos builders do pacote
/// OpenAPI.
class ProdutoModel {
  final String? id;
  final String nome;
  final String descricao;
  final String preco;
  final String categoria; // 'PRODUCT' ou 'SERVICE'
  final String imagemPrincipal;
  final List<String> imagensAdicionais;
  final String userId;
  final String regiaoAtendimento;
  final DateTime? criadoEm;

  const ProdutoModel({
    this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoria,
    required this.imagemPrincipal,
    this.imagensAdicionais = const [],
    required this.userId,
    required this.regiaoAtendimento,
    this.criadoEm,
  });

  factory ProdutoModel.fromDto(ProdutoResponseDto dto) {
    return ProdutoModel(
      id: dto.id,
      nome: dto.nome,
      descricao: dto.descricao,
      preco: dto.preco,
      categoria: dto.categoria,
      imagemPrincipal: dto.imagemPrincipal,
      imagensAdicionais: dto.imagensAdicionais?.toList() ?? const [],
      userId: dto.userId,
      regiaoAtendimento: dto.regiaoAtendimento,
      criadoEm: dto.criadoEm,
    );
  }

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'] as String?,
      nome: json['nome'] as String? ?? '',
      descricao: json['descricao'] as String? ?? '',
      preco: json['preco']?.toString() ?? '',
      categoria: json['categoria'] as String? ?? '',
      imagemPrincipal: json['imagemPrincipal'] as String? ?? '',
      imagensAdicionais: (json['imagensAdicionais'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList(growable: false) ??
          const [],
      userId: json['userId'] as String? ?? '',
      regiaoAtendimento: json['regiaoAtendimento'] as String? ?? '',
      criadoEm: json['criado_em'] != null
          ? DateTime.tryParse(json['criado_em'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
        'descricao': descricao,
        'preco': preco,
        'categoria': categoria,
        'imagemPrincipal': imagemPrincipal,
        'imagensAdicionais': imagensAdicionais,
        'userId': userId,
        'regiaoAtendimento': regiaoAtendimento,
      };

  String get precoFormatado {
    final valor = preco.trim();
    if (valor.toLowerCase().startsWith('r\$')) return valor;

    final numero = double.tryParse(valor.replaceAll(',', '.'));
    if (numero != null) {
      return 'R\$ ${numero.toStringAsFixed(2).replaceAll('.', ',')}';
    }
    return valor;
  }
}
