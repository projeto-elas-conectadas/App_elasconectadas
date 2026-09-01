//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:openapi/src/model/erro_padrao_message.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'erro_padrao.g.dart';

/// ErroPadrao
///
/// Properties:
/// * [statusCode] - Código do status HTTP
/// * [message] 
/// * [error] - Nome oficial do erro HTTP
/// * [path] - Rota em que o erro ocorreu
/// * [errors] - Detalhes do validador OpenAPI, quando existirem
@BuiltValue()
abstract class ErroPadrao implements Built<ErroPadrao, ErroPadraoBuilder> {
  /// Código do status HTTP
  @BuiltValueField(wireName: r'statusCode')
  int? get statusCode;

  @BuiltValueField(wireName: r'message')
  ErroPadraoMessage? get message;

  /// Nome oficial do erro HTTP
  @BuiltValueField(wireName: r'error')
  String? get error;

  /// Rota em que o erro ocorreu
  @BuiltValueField(wireName: r'path')
  String? get path;

  /// Detalhes do validador OpenAPI, quando existirem
  @BuiltValueField(wireName: r'errors')
  BuiltList<BuiltMap<String, JsonObject?>>? get errors;

  ErroPadrao._();

  factory ErroPadrao([void updates(ErroPadraoBuilder b)]) = _$ErroPadrao;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErroPadraoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErroPadrao> get serializer => _$ErroPadraoSerializer();
}

class _$ErroPadraoSerializer implements PrimitiveSerializer<ErroPadrao> {
  @override
  final Iterable<Type> types = const [ErroPadrao, _$ErroPadrao];

  @override
  final String wireName = r'ErroPadrao';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErroPadrao object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.statusCode != null) {
      yield r'statusCode';
      yield serializers.serialize(
        object.statusCode,
        specifiedType: const FullType(int),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(ErroPadraoMessage),
      );
    }
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType(String),
      );
    }
    if (object.path != null) {
      yield r'path';
      yield serializers.serialize(
        object.path,
        specifiedType: const FullType(String),
      );
    }
    if (object.errors != null) {
      yield r'errors';
      yield serializers.serialize(
        object.errors,
        specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ErroPadrao object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ErroPadraoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'statusCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.statusCode = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ErroPadraoMessage),
          ) as ErroPadraoMessage;
          result.message.replace(valueDes);
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.error = valueDes;
          break;
        case r'path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.path = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
          ) as BuiltList<BuiltMap<String, JsonObject?>>;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ErroPadrao deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErroPadraoBuilder();
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

