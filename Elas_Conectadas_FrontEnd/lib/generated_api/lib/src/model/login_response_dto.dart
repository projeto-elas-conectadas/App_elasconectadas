//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_response_dto.g.dart';

/// LoginResponseDto
///
/// Properties:
/// * [accessToken] - Token JWT para autenticação
/// * [user] - Dados básicos da usuária logada
@BuiltValue()
abstract class LoginResponseDto implements Built<LoginResponseDto, LoginResponseDtoBuilder> {
  /// Token JWT para autenticação
  @BuiltValueField(wireName: r'access_token')
  String? get accessToken;

  /// Dados básicos da usuária logada
  @BuiltValueField(wireName: r'user')
  JsonObject? get user;

  LoginResponseDto._();

  factory LoginResponseDto([void updates(LoginResponseDtoBuilder b)]) = _$LoginResponseDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginResponseDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginResponseDto> get serializer => _$LoginResponseDtoSerializer();
}

class _$LoginResponseDtoSerializer implements PrimitiveSerializer<LoginResponseDto> {
  @override
  final Iterable<Type> types = const [LoginResponseDto, _$LoginResponseDto];

  @override
  final String wireName = r'LoginResponseDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.accessToken != null) {
      yield r'access_token';
      yield serializers.serialize(
        object.accessToken,
        specifiedType: const FullType(String),
      );
    }
    if (object.user != null) {
      yield r'user';
      yield serializers.serialize(
        object.user,
        specifiedType: const FullType(JsonObject),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginResponseDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.user = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginResponseDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginResponseDtoBuilder();
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

