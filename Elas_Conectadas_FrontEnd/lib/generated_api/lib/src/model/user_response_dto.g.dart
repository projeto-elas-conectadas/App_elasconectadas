// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserResponseDtoRoleEnum _$userResponseDtoRoleEnum_USER =
    const UserResponseDtoRoleEnum._('USER');
const UserResponseDtoRoleEnum _$userResponseDtoRoleEnum_ADMIN =
    const UserResponseDtoRoleEnum._('ADMIN');

UserResponseDtoRoleEnum _$userResponseDtoRoleEnumValueOf(String name) {
  switch (name) {
    case 'USER':
      return _$userResponseDtoRoleEnum_USER;
    case 'ADMIN':
      return _$userResponseDtoRoleEnum_ADMIN;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserResponseDtoRoleEnum> _$userResponseDtoRoleEnumValues =
    BuiltSet<UserResponseDtoRoleEnum>(const <UserResponseDtoRoleEnum>[
  _$userResponseDtoRoleEnum_USER,
  _$userResponseDtoRoleEnum_ADMIN,
]);

const UserResponseDtoAccountStatusEnum
    _$userResponseDtoAccountStatusEnum_VERIFIED =
    const UserResponseDtoAccountStatusEnum._('VERIFIED');
const UserResponseDtoAccountStatusEnum
    _$userResponseDtoAccountStatusEnum_UNVERIFIED =
    const UserResponseDtoAccountStatusEnum._('UNVERIFIED');

UserResponseDtoAccountStatusEnum _$userResponseDtoAccountStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'VERIFIED':
      return _$userResponseDtoAccountStatusEnum_VERIFIED;
    case 'UNVERIFIED':
      return _$userResponseDtoAccountStatusEnum_UNVERIFIED;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserResponseDtoAccountStatusEnum>
    _$userResponseDtoAccountStatusEnumValues = BuiltSet<
        UserResponseDtoAccountStatusEnum>(const <UserResponseDtoAccountStatusEnum>[
  _$userResponseDtoAccountStatusEnum_VERIFIED,
  _$userResponseDtoAccountStatusEnum_UNVERIFIED,
]);

Serializer<UserResponseDtoRoleEnum> _$userResponseDtoRoleEnumSerializer =
    _$UserResponseDtoRoleEnumSerializer();
Serializer<UserResponseDtoAccountStatusEnum>
    _$userResponseDtoAccountStatusEnumSerializer =
    _$UserResponseDtoAccountStatusEnumSerializer();

class _$UserResponseDtoRoleEnumSerializer
    implements PrimitiveSerializer<UserResponseDtoRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USER': 'USER',
    'ADMIN': 'ADMIN',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USER': 'USER',
    'ADMIN': 'ADMIN',
  };

  @override
  final Iterable<Type> types = const <Type>[UserResponseDtoRoleEnum];
  @override
  final String wireName = 'UserResponseDtoRoleEnum';

  @override
  Object serialize(Serializers serializers, UserResponseDtoRoleEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserResponseDtoRoleEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserResponseDtoRoleEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserResponseDtoAccountStatusEnumSerializer
    implements PrimitiveSerializer<UserResponseDtoAccountStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'VERIFIED': 'VERIFIED',
    'UNVERIFIED': 'UNVERIFIED',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'VERIFIED': 'VERIFIED',
    'UNVERIFIED': 'UNVERIFIED',
  };

  @override
  final Iterable<Type> types = const <Type>[UserResponseDtoAccountStatusEnum];
  @override
  final String wireName = 'UserResponseDtoAccountStatusEnum';

  @override
  Object serialize(
          Serializers serializers, UserResponseDtoAccountStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserResponseDtoAccountStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserResponseDtoAccountStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserResponseDto extends UserResponseDto {
  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? dob;
  @override
  final String? occupation;
  @override
  final String? rua;
  @override
  final String? numero;
  @override
  final String? bairro;
  @override
  final String? cidade;
  @override
  final String? estado;
  @override
  final String? bio;
  @override
  final String? pfp;
  @override
  final UserResponseDtoRoleEnum role;
  @override
  final UserResponseDtoAccountStatusEnum accountStatus;

  factory _$UserResponseDto([void Function(UserResponseDtoBuilder)? updates]) =>
      (UserResponseDtoBuilder()..update(updates))._build();

  _$UserResponseDto._(
      {required this.id,
      required this.email,
      required this.name,
      this.phone,
      this.dob,
      this.occupation,
      this.rua,
      this.numero,
      this.bairro,
      this.cidade,
      this.estado,
      this.bio,
      this.pfp,
      required this.role,
      required this.accountStatus})
      : super._();
  @override
  UserResponseDto rebuild(void Function(UserResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserResponseDtoBuilder toBuilder() => UserResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserResponseDto &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        phone == other.phone &&
        dob == other.dob &&
        occupation == other.occupation &&
        rua == other.rua &&
        numero == other.numero &&
        bairro == other.bairro &&
        cidade == other.cidade &&
        estado == other.estado &&
        bio == other.bio &&
        pfp == other.pfp &&
        role == other.role &&
        accountStatus == other.accountStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, dob.hashCode);
    _$hash = $jc(_$hash, occupation.hashCode);
    _$hash = $jc(_$hash, rua.hashCode);
    _$hash = $jc(_$hash, numero.hashCode);
    _$hash = $jc(_$hash, bairro.hashCode);
    _$hash = $jc(_$hash, cidade.hashCode);
    _$hash = $jc(_$hash, estado.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, pfp.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, accountStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserResponseDto')
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('phone', phone)
          ..add('dob', dob)
          ..add('occupation', occupation)
          ..add('rua', rua)
          ..add('numero', numero)
          ..add('bairro', bairro)
          ..add('cidade', cidade)
          ..add('estado', estado)
          ..add('bio', bio)
          ..add('pfp', pfp)
          ..add('role', role)
          ..add('accountStatus', accountStatus))
        .toString();
  }
}

class UserResponseDtoBuilder
    implements Builder<UserResponseDto, UserResponseDtoBuilder> {
  _$UserResponseDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _dob;
  String? get dob => _$this._dob;
  set dob(String? dob) => _$this._dob = dob;

  String? _occupation;
  String? get occupation => _$this._occupation;
  set occupation(String? occupation) => _$this._occupation = occupation;

  String? _rua;
  String? get rua => _$this._rua;
  set rua(String? rua) => _$this._rua = rua;

  String? _numero;
  String? get numero => _$this._numero;
  set numero(String? numero) => _$this._numero = numero;

  String? _bairro;
  String? get bairro => _$this._bairro;
  set bairro(String? bairro) => _$this._bairro = bairro;

  String? _cidade;
  String? get cidade => _$this._cidade;
  set cidade(String? cidade) => _$this._cidade = cidade;

  String? _estado;
  String? get estado => _$this._estado;
  set estado(String? estado) => _$this._estado = estado;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  String? _pfp;
  String? get pfp => _$this._pfp;
  set pfp(String? pfp) => _$this._pfp = pfp;

  UserResponseDtoRoleEnum? _role;
  UserResponseDtoRoleEnum? get role => _$this._role;
  set role(UserResponseDtoRoleEnum? role) => _$this._role = role;

  UserResponseDtoAccountStatusEnum? _accountStatus;
  UserResponseDtoAccountStatusEnum? get accountStatus => _$this._accountStatus;
  set accountStatus(UserResponseDtoAccountStatusEnum? accountStatus) =>
      _$this._accountStatus = accountStatus;

  UserResponseDtoBuilder() {
    UserResponseDto._defaults(this);
  }

  UserResponseDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _phone = $v.phone;
      _dob = $v.dob;
      _occupation = $v.occupation;
      _rua = $v.rua;
      _numero = $v.numero;
      _bairro = $v.bairro;
      _cidade = $v.cidade;
      _estado = $v.estado;
      _bio = $v.bio;
      _pfp = $v.pfp;
      _role = $v.role;
      _accountStatus = $v.accountStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserResponseDto other) {
    _$v = other as _$UserResponseDto;
  }

  @override
  void update(void Function(UserResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserResponseDto build() => _build();

  _$UserResponseDto _build() {
    final _$result = _$v ??
        _$UserResponseDto._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'UserResponseDto', 'id'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'UserResponseDto', 'email'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'UserResponseDto', 'name'),
          phone: phone,
          dob: dob,
          occupation: occupation,
          rua: rua,
          numero: numero,
          bairro: bairro,
          cidade: cidade,
          estado: estado,
          bio: bio,
          pfp: pfp,
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'UserResponseDto', 'role'),
          accountStatus: BuiltValueNullFieldError.checkNotNull(
              accountStatus, r'UserResponseDto', 'accountStatus'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
