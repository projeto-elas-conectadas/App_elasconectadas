import 'package:elasconectadas_app/core/models/produto_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

void main() {
  const produtoJson = <String, dynamic>{
    'id': 'cfe231d2-74a6-44dd-a3dc-fd50c6f73e31',
    'nome': 'Bolo artesanal',
    'descricao': 'Bolo sob encomenda',
    'preco': 'R\$ 80 - R\$ 120',
    'categoria': 'PRODUCT',
    'imagemPrincipal': 'https://res.cloudinary.com/teste/imagem.jpg',
    'imagensAdicionais': <String>[
      'https://res.cloudinary.com/teste/imagem-2.jpg',
    ],
    'userId': '42ddab2c-6d0b-4cf6-8075-8dc038c5096e',
    'regiaoAtendimento': 'Itambaracá e região',
    'criado_em': '2026-08-19T12:00:00.000Z',
  };

  test('desserializa a resposta OpenAPI e adapta para ProdutoModel', () {
    final dto = standardSerializers.deserializeWith(
      ProdutoResponseDto.serializer,
      produtoJson,
    );

    expect(dto, isNotNull);
    final produto = ProdutoModel.fromDto(dto!);
    expect(produto.preco, 'R\$ 80 - R\$ 120');
    expect(produto.precoFormatado, 'R\$ 80 - R\$ 120');
    expect(produto.imagemPrincipal, produtoJson['imagemPrincipal']);
    expect(produto.imagensAdicionais, hasLength(1));
    expect(produto.regiaoAtendimento, 'Itambaracá e região');
  });

  test('serializa CreateProdutoDto com os nomes definidos pelo contrato', () {
    final dto = CreateProdutoDto((builder) => builder
      ..nome = 'Consultoria'
      ..descricao = 'Consultoria para pequenos negócios'
      ..preco = 'A partir de R\$ 120'
      ..categoria = 'SERVICE'
      ..imagemPrincipal = 'https://res.cloudinary.com/teste/consultoria.jpg'
      ..imagensAdicionais = ListBuilder<String>([
        'https://res.cloudinary.com/teste/consultoria-2.jpg',
        'https://res.cloudinary.com/teste/consultoria-3.jpg',
      ])
      ..userId = '42ddab2c-6d0b-4cf6-8075-8dc038c5096e'
      ..regiaoAtendimento = 'Atendimento on-line');

    final json = standardSerializers.serializeWith(
      CreateProdutoDto.serializer,
      dto,
    ) as Map<String, dynamic>;

    expect(json['preco'], 'A partir de R\$ 120');
    expect(json['imagemPrincipal'], contains('cloudinary.com'));
    expect(json['imagensAdicionais'], hasLength(2));
    expect(json['regiaoAtendimento'], 'Atendimento on-line');
    expect(json, isNot(contains('imagemUrl')));
  });

  test('desserializa a URL tipada devolvida pelo upload', () {
    final response = standardSerializers.deserializeWith(
      UploadResponseDto.serializer,
      const <String, dynamic>{
        'imageUrl': 'https://res.cloudinary.com/teste/upload.jpg',
      },
    );

    expect(response?.imageUrl, 'https://res.cloudinary.com/teste/upload.jpg');
  });
}
