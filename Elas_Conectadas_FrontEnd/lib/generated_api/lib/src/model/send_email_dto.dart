//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_email_dto.g.dart';

/// SendEmailDto
///
/// Properties:
/// * [email] - E-mail da destinatária
@BuiltValue()
abstract class SendEmailDto implements Built<SendEmailDto, SendEmailDtoBuilder> {
  /// E-mail da destinatária
  @BuiltValueField(wireName: r'email')
  String get email;

  SendEmailDto._();

  factory SendEmailDto([void updates(SendEmailDtoBuilder b)]) = _$SendEmailDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendEmailDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendEmailDto> get serializer => _$SendEmailDtoSerializer();
}

class _$SendEmailDtoSerializer implements PrimitiveSerializer<SendEmailDto> {
  @override
  final Iterable<Type> types = const [SendEmailDto, _$SendEmailDto];

  @override
  final String wireName = r'SendEmailDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendEmailDto object, {
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
    SendEmailDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendEmailDtoBuilder result,
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
  SendEmailDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendEmailDtoBuilder();
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

