//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_produto_dto.g.dart';

/// CreateProdutoDto
///
/// Properties:
/// * [nome] 
/// * [descricao] 
/// * [preco] 
/// * [categoria] 
/// * [imagemPrincipal] - URL da imagem de capa do produto
/// * [imagensAdicionais] - Lista com URLs de fotos extras do produto
/// * [userId] 
/// * [regiaoAtendimento] - Cidades atendidas ou tipo de atendimento
@BuiltValue()
abstract class CreateProdutoDto implements Built<CreateProdutoDto, CreateProdutoDtoBuilder> {
  @BuiltValueField(wireName: r'nome')
  String get nome;

  @BuiltValueField(wireName: r'descricao')
  String get descricao;

  @BuiltValueField(wireName: r'preco')
  String get preco;

  @BuiltValueField(wireName: r'categoria')
  String get categoria;

  /// URL da imagem de capa do produto
  @BuiltValueField(wireName: r'imagemPrincipal')
  String get imagemPrincipal;

  /// Lista com URLs de fotos extras do produto
  @BuiltValueField(wireName: r'imagensAdicionais')
  BuiltList<String>? get imagensAdicionais;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  /// Cidades atendidas ou tipo de atendimento
  @BuiltValueField(wireName: r'regiaoAtendimento')
  String get regiaoAtendimento;

  CreateProdutoDto._();

  factory CreateProdutoDto([void updates(CreateProdutoDtoBuilder b)]) = _$CreateProdutoDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateProdutoDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateProdutoDto> get serializer => _$CreateProdutoDtoSerializer();
}

class _$CreateProdutoDtoSerializer implements PrimitiveSerializer<CreateProdutoDto> {
  @override
  final Iterable<Type> types = const [CreateProdutoDto, _$CreateProdutoDto];

  @override
  final String wireName = r'CreateProdutoDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateProdutoDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'nome';
    yield serializers.serialize(
      object.nome,
      specifiedType: const FullType(String),
    );
    yield r'descricao';
    yield serializers.serialize(
      object.descricao,
      specifiedType: const FullType(String),
    );
    yield r'preco';
    yield serializers.serialize(
      object.preco,
      specifiedType: const FullType(String),
    );
    yield r'categoria';
    yield serializers.serialize(
      object.categoria,
      specifiedType: const FullType(String),
    );
    yield r'imagemPrincipal';
    yield serializers.serialize(
      object.imagemPrincipal,
      specifiedType: const FullType(String),
    );
    if (object.imagensAdicionais != null) {
      yield r'imagensAdicionais';
      yield serializers.serialize(
        object.imagensAdicionais,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    yield r'regiaoAtendimento';
    yield serializers.serialize(
      object.regiaoAtendimento,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateProdutoDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateProdutoDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nome':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nome = valueDes;
          break;
        case r'descricao':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.descricao = valueDes;
          break;
        case r'preco':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.preco = valueDes;
          break;
        case r'categoria':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categoria = valueDes;
          break;
        case r'imagemPrincipal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imagemPrincipal = valueDes;
          break;
        case r'imagensAdicionais':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.imagensAdicionais.replace(valueDes);
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'regiaoAtendimento':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.regiaoAtendimento = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateProdutoDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateProdutoDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

