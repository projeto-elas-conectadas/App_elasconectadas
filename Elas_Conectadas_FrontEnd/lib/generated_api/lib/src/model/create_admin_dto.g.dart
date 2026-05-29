// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_admin_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAdminDto extends CreateAdminDto {
  @override
  final String email;
  @override
  final String password;
  @override
  final String name;

  factory _$CreateAdminDto([void Function(CreateAdminDtoBuilder)? updates]) =>
      (CreateAdminDtoBuilder()..update(updates))._build();

  _$CreateAdminDto._(
      {required this.email, required this.password, required this.name})
      : super._();
  @override
  CreateAdminDto rebuild(void Function(CreateAdminDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAdminDtoBuilder toBuilder() => CreateAdminDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAdminDto &&
        email == other.email &&
        password == other.password &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAdminDto')
          ..add('email', email)
          ..add('password', password)
          ..add('name', name))
        .toString();
  }
}

class CreateAdminDtoBuilder
    implements Builder<CreateAdminDto, CreateAdminDtoBuilder> {
  _$CreateAdminDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  CreateAdminDtoBuilder() {
    CreateAdminDto._defaults(this);
  }

  CreateAdminDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAdminDto other) {
    _$v = other as _$CreateAdminDto;
  }

  @override
  void update(void Function(CreateAdminDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAdminDto build() => _build();

  _$CreateAdminDto _build() {
    final _$result = _$v ??
        _$CreateAdminDto._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'CreateAdminDto', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'CreateAdminDto', 'password'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'CreateAdminDto', 'name'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
