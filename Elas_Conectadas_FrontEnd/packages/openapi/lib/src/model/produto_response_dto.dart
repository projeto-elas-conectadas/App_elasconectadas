//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'produto_response_dto.g.dart';

/// ProdutoResponseDto
///
/// Properties:
/// * [id] 
/// * [nome] 
/// * [descricao] 
/// * [preco] - Preço ou faixa de preço, conforme informado pela usuária
/// * [categoria] 
/// * [imagemPrincipal] 
/// * [imagensAdicionais] 
/// * [userId] 
/// * [regiaoAtendimento] 
/// * [criadoEm] 
@BuiltValue()
abstract class ProdutoResponseDto implements Built<ProdutoResponseDto, ProdutoResponseDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'nome')
  String get nome;

  @BuiltValueField(wireName: r'descricao')
  String get descricao;

  /// Preço ou faixa de preço, conforme informado pela usuária
  @BuiltValueField(wireName: r'preco')
  String get preco;

  @BuiltValueField(wireName: r'categoria')
  String get categoria;

  @BuiltValueField(wireName: r'imagemPrincipal')
  String get imagemPrincipal;

  @BuiltValueField(wireName: r'imagensAdicionais')
  BuiltList<String>? get imagensAdicionais;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'regiaoAtendimento')
  String get regiaoAtendimento;

  @BuiltValueField(wireName: r'criado_em')
  DateTime get criadoEm;

  ProdutoResponseDto._();

  factory ProdutoResponseDto([void updates(ProdutoResponseDtoBuilder b)]) = _$ProdutoResponseDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProdutoResponseDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProdutoResponseDto> get serializer => _$ProdutoResponseDtoSerializer();
}

class _$ProdutoResponseDtoSerializer implements PrimitiveSerializer<ProdutoResponseDto> {
  @override
  final Iterable<Type> types = const [ProdutoResponseDto, _$ProdutoResponseDto];

  @override
  final String wireName = r'ProdutoResponseDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProdutoResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
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
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
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
    yield r'criado_em';
    yield serializers.serialize(
      object.criadoEm,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProdutoResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProdutoResponseDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
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
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
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
        case r'criado_em':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.criadoEm = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProdutoResponseDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProdutoResponseDtoBuilder();
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

