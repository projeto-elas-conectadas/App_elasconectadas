//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'request_token_dto.g.dart';

/// RequestTokenDto
///
/// Properties:
/// * [email] 
@BuiltValue()
abstract class RequestTokenDto implements Built<RequestTokenDto, RequestTokenDtoBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  RequestTokenDto._();

  factory RequestTokenDto([void updates(RequestTokenDtoBuilder b)]) = _$RequestTokenDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RequestTokenDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RequestTokenDto> get serializer => _$RequestTokenDtoSerializer();
}

class _$RequestTokenDtoSerializer implements PrimitiveSerializer<RequestTokenDto> {
  @override
  final Iterable<Type> types = const [RequestTokenDto, _$RequestTokenDto];

  @override
  final String wireName = r'RequestTokenDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RequestTokenDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RequestTokenDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RequestTokenDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RequestTokenDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RequestTokenDtoBuilder();
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

