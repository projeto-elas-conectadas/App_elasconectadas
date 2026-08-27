// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_token_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RequestTokenDto extends RequestTokenDto {
  @override
  final String email;

  factory _$RequestTokenDto([void Function(RequestTokenDtoBuilder)? updates]) =>
      (RequestTokenDtoBuilder()..update(updates))._build();

  _$RequestTokenDto._({required this.email}) : super._();
  @override
  RequestTokenDto rebuild(void Function(RequestTokenDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RequestTokenDtoBuilder toBuilder() => RequestTokenDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RequestTokenDto && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RequestTokenDto')
          ..add('email', email))
        .toString();
  }
}

class RequestTokenDtoBuilder
    implements Builder<RequestTokenDto, RequestTokenDtoBuilder> {
  _$RequestTokenDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  RequestTokenDtoBuilder() {
    RequestTokenDto._defaults(this);
  }

  RequestTokenDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestTokenDto other) {
    _$v = other as _$RequestTokenDto;
  }

  @override
  void update(void Function(RequestTokenDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RequestTokenDto build() => _build();

  _$RequestTokenDto _build() {
    final _$result = _$v ??
        _$RequestTokenDto._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'RequestTokenDto', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
