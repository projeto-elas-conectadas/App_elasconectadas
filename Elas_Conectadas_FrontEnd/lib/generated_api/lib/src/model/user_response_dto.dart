//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_response_dto.g.dart';

/// UserResponseDto
///
/// Properties:
/// * [id] 
/// * [email] 
/// * [name] 
/// * [phone] 
/// * [dob] - Data de nascimento no formato DD/MM/AAAA
/// * [occupation] 
/// * [rua] 
/// * [numero] 
/// * [bairro] 
/// * [cidade] 
/// * [estado] 
/// * [bio] 
/// * [pfp] 
/// * [role] 
/// * [accountStatus] 
@BuiltValue()
abstract class UserResponseDto implements Built<UserResponseDto, UserResponseDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'phone')
  String? get phone;

  /// Data de nascimento no formato DD/MM/AAAA
  @BuiltValueField(wireName: r'dob')
  String? get dob;

  @BuiltValueField(wireName: r'occupation')
  String? get occupation;

  @BuiltValueField(wireName: r'rua')
  String? get rua;

  @BuiltValueField(wireName: r'numero')
  String? get numero;

  @BuiltValueField(wireName: r'bairro')
  String? get bairro;

  @BuiltValueField(wireName: r'cidade')
  String? get cidade;

  @BuiltValueField(wireName: r'estado')
  String? get estado;

  @BuiltValueField(wireName: r'bio')
  String? get bio;

  @BuiltValueField(wireName: r'pfp')
  String? get pfp;

  @BuiltValueField(wireName: r'role')
  UserResponseDtoRoleEnum get role;
  // enum roleEnum {  USER,  ADMIN,  };

  @BuiltValueField(wireName: r'accountStatus')
  UserResponseDtoAccountStatusEnum get accountStatus;
  // enum accountStatusEnum {  VERIFIED,  UNVERIFIED,  };

  UserResponseDto._();

  factory UserResponseDto([void updates(UserResponseDtoBuilder b)]) = _$UserResponseDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserResponseDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserResponseDto> get serializer => _$UserResponseDtoSerializer();
}

class _$UserResponseDtoSerializer implements PrimitiveSerializer<UserResponseDto> {
  @override
  final Iterable<Type> types = const [UserResponseDto, _$UserResponseDto];

  @override
  final String wireName = r'UserResponseDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.dob != null) {
      yield r'dob';
      yield serializers.serialize(
        object.dob,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.occupation != null) {
      yield r'occupation';
      yield serializers.serialize(
        object.occupation,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.rua != null) {
      yield r'rua';
      yield serializers.serialize(
        object.rua,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.numero != null) {
      yield r'numero';
      yield serializers.serialize(
        object.numero,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bairro != null) {
      yield r'bairro';
      yield serializers.serialize(
        object.bairro,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.cidade != null) {
      yield r'cidade';
      yield serializers.serialize(
        object.cidade,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.estado != null) {
      yield r'estado';
      yield serializers.serialize(
        object.estado,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bio != null) {
      yield r'bio';
      yield serializers.serialize(
        object.bio,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.pfp != null) {
      yield r'pfp';
      yield serializers.serialize(
        object.pfp,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(UserResponseDtoRoleEnum),
    );
    yield r'accountStatus';
    yield serializers.serialize(
      object.accountStatus,
      specifiedType: const FullType(UserResponseDtoAccountStatusEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UserResponseDtoBuilder result,
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phone = valueDes;
          break;
        case r'dob':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.dob = valueDes;
          break;
        case r'occupation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.occupation = valueDes;
          break;
        case r'rua':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.rua = valueDes;
          break;
        case r'numero':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.numero = valueDes;
          break;
        case r'bairro':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bairro = valueDes;
          break;
        case r'cidade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.cidade = valueDes;
          break;
        case r'estado':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estado = valueDes;
          break;
        case r'bio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bio = valueDes;
          break;
        case r'pfp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pfp = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserResponseDtoRoleEnum),
          ) as UserResponseDtoRoleEnum;
          result.role = valueDes;
          break;
        case r'accountStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserResponseDtoAccountStatusEnum),
          ) as UserResponseDtoAccountStatusEnum;
          result.accountStatus = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserResponseDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserResponseDtoBuilder();
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

class UserResponseDtoRoleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'USER')
  static const UserResponseDtoRoleEnum USER = _$userResponseDtoRoleEnum_USER;
  @BuiltValueEnumConst(wireName: r'ADMIN')
  static const UserResponseDtoRoleEnum ADMIN = _$userResponseDtoRoleEnum_ADMIN;

  static Serializer<UserResponseDtoRoleEnum> get serializer => _$userResponseDtoRoleEnumSerializer;

  const UserResponseDtoRoleEnum._(String name): super(name);

  static BuiltSet<UserResponseDtoRoleEnum> get values => _$userResponseDtoRoleEnumValues;
  static UserResponseDtoRoleEnum valueOf(String name) => _$userResponseDtoRoleEnumValueOf(name);
}

class UserResponseDtoAccountStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'VERIFIED')
  static const UserResponseDtoAccountStatusEnum VERIFIED = _$userResponseDtoAccountStatusEnum_VERIFIED;
  @BuiltValueEnumConst(wireName: r'UNVERIFIED')
  static const UserResponseDtoAccountStatusEnum UNVERIFIED = _$userResponseDtoAccountStatusEnum_UNVERIFIED;

  static Serializer<UserResponseDtoAccountStatusEnum> get serializer => _$userResponseDtoAccountStatusEnumSerializer;

  const UserResponseDtoAccountStatusEnum._(String name): super(name);

  static BuiltSet<UserResponseDtoAccountStatusEnum> get values => _$userResponseDtoAccountStatusEnumValues;
  static UserResponseDtoAccountStatusEnum valueOf(String name) => _$userResponseDtoAccountStatusEnumValueOf(name);
}

