// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginResponseDto extends LoginResponseDto {
  @override
  final String? accessToken;
  @override
  final UserResponseDto? user;

  factory _$LoginResponseDto(
          [void Function(LoginResponseDtoBuilder)? updates]) =>
      (LoginResponseDtoBuilder()..update(updates))._build();

  _$LoginResponseDto._({this.accessToken, this.user}) : super._();
  @override
  LoginResponseDto rebuild(void Function(LoginResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseDtoBuilder toBuilder() =>
      LoginResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginResponseDto &&
        accessToken == other.accessToken &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginResponseDto')
          ..add('accessToken', accessToken)
          ..add('user', user))
        .toString();
  }
}

class LoginResponseDtoBuilder
    implements Builder<LoginResponseDto, LoginResponseDtoBuilder> {
  _$LoginResponseDto? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  UserResponseDtoBuilder? _user;
  UserResponseDtoBuilder get user => _$this._user ??= UserResponseDtoBuilder();
  set user(UserResponseDtoBuilder? user) => _$this._user = user;

  LoginResponseDtoBuilder() {
    LoginResponseDto._defaults(this);
  }

  LoginResponseDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _user = $v.user?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponseDto other) {
    _$v = other as _$LoginResponseDto;
  }

  @override
  void update(void Function(LoginResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginResponseDto build() => _build();

  _$LoginResponseDto _build() {
    _$LoginResponseDto _$result;
    try {
      _$result = _$v ??
          _$LoginResponseDto._(
            accessToken: accessToken,
            user: _user?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'LoginResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
