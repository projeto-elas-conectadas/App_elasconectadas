//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'dart:core';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'erro_padrao_message.g.dart';

/// Mensagem detalhada sobre o que deu errado
@BuiltValue()
abstract class ErroPadraoMessage implements Built<ErroPadraoMessage, ErroPadraoMessageBuilder> {
  /// One Of [BuiltList<String>], [String]
  OneOf get oneOf;

  ErroPadraoMessage._();

  factory ErroPadraoMessage([void updates(ErroPadraoMessageBuilder b)]) = _$ErroPadraoMessage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErroPadraoMessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErroPadraoMessage> get serializer => _$ErroPadraoMessageSerializer();
}

class _$ErroPadraoMessageSerializer implements PrimitiveSerializer<ErroPadraoMessage> {
  @override
  final Iterable<Type> types = const [ErroPadraoMessage, _$ErroPadraoMessage];

  @override
  final String wireName = r'ErroPadraoMessage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErroPadraoMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ErroPadraoMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  ErroPadraoMessage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErroPadraoMessageBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(String), FullType(BuiltList, [FullType(String)]), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

