//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'erro_nao_encontrado.g.dart';

/// ErroNaoEncontrado
///
/// Properties:
/// * [statusCode] 
/// * [message] 
/// * [error] 
/// * [path] 
@BuiltValue()
abstract class ErroNaoEncontrado implements Built<ErroNaoEncontrado, ErroNaoEncontradoBuilder> {
  @BuiltValueField(wireName: r'statusCode')
  int? get statusCode;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'error')
  String? get error;

  @BuiltValueField(wireName: r'path')
  String? get path;

  ErroNaoEncontrado._();

  factory ErroNaoEncontrado([void updates(ErroNaoEncontradoBuilder b)]) = _$ErroNaoEncontrado;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErroNaoEncontradoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErroNaoEncontrado> get serializer => _$ErroNaoEncontradoSerializer();
}

class _$ErroNaoEncontradoSerializer implements PrimitiveSerializer<ErroNaoEncontrado> {
  @override
  final Iterable<Type> types = const [ErroNaoEncontrado, _$ErroNaoEncontrado];

  @override
  final String wireName = r'ErroNaoEncontrado';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErroNaoEncontrado object, {
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
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ErroNaoEncontrado object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ErroNaoEncontradoBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ErroNaoEncontrado deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErroNaoEncontradoBuilder();
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

