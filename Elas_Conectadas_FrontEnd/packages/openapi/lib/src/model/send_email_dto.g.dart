// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendEmailDto extends SendEmailDto {
  @override
  final String email;

  factory _$SendEmailDto([void Function(SendEmailDtoBuilder)? updates]) =>
      (SendEmailDtoBuilder()..update(updates))._build();

  _$SendEmailDto._({required this.email}) : super._();
  @override
  SendEmailDto rebuild(void Function(SendEmailDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendEmailDtoBuilder toBuilder() => SendEmailDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendEmailDto && email == other.email;
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
    return (newBuiltValueToStringHelper(r'SendEmailDto')..add('email', email))
        .toString();
  }
}

class SendEmailDtoBuilder
    implements Builder<SendEmailDto, SendEmailDtoBuilder> {
  _$SendEmailDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  SendEmailDtoBuilder() {
    SendEmailDto._defaults(this);
  }

  SendEmailDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendEmailDto other) {
    _$v = other as _$SendEmailDto;
  }

  @override
  void update(void Function(SendEmailDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendEmailDto build() => _build();

  _$SendEmailDto _build() {
    final _$result = _$v ??
        _$SendEmailDto._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'SendEmailDto', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
