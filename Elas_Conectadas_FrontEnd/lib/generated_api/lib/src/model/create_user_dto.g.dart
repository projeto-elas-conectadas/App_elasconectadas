// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateUserDto extends CreateUserDto {
  @override
  final String email;
  @override
  final String password;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String dob;

  factory _$CreateUserDto([void Function(CreateUserDtoBuilder)? updates]) =>
      (CreateUserDtoBuilder()..update(updates))._build();

  _$CreateUserDto._(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone,
      required this.dob})
      : super._();
  @override
  CreateUserDto rebuild(void Function(CreateUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateUserDtoBuilder toBuilder() => CreateUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateUserDto &&
        email == other.email &&
        password == other.password &&
        name == other.name &&
        phone == other.phone &&
        dob == other.dob;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, dob.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateUserDto')
          ..add('email', email)
          ..add('password', password)
          ..add('name', name)
          ..add('phone', phone)
          ..add('dob', dob))
        .toString();
  }
}

class CreateUserDtoBuilder
    implements Builder<CreateUserDto, CreateUserDtoBuilder> {
  _$CreateUserDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _dob;
  String? get dob => _$this._dob;
  set dob(String? dob) => _$this._dob = dob;

  CreateUserDtoBuilder() {
    CreateUserDto._defaults(this);
  }

  CreateUserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _name = $v.name;
      _phone = $v.phone;
      _dob = $v.dob;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateUserDto other) {
    _$v = other as _$CreateUserDto;
  }

  @override
  void update(void Function(CreateUserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateUserDto build() => _build();

  _$CreateUserDto _build() {
    final _$result = _$v ??
        _$CreateUserDto._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'CreateUserDto', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'CreateUserDto', 'password'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreateUserDto', 'name'),
          phone: BuiltValueNullFieldError.checkNotNull(
              phone, r'CreateUserDto', 'phone'),
          dob: BuiltValueNullFieldError.checkNotNull(
              dob, r'CreateUserDto', 'dob'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
