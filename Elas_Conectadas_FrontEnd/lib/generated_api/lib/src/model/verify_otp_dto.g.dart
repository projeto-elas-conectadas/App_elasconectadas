// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyOtpDto extends VerifyOtpDto {
  @override
  final String email;
  @override
  final String otp;

  factory _$VerifyOtpDto([void Function(VerifyOtpDtoBuilder)? updates]) =>
      (VerifyOtpDtoBuilder()..update(updates))._build();

  _$VerifyOtpDto._({required this.email, required this.otp}) : super._();
  @override
  VerifyOtpDto rebuild(void Function(VerifyOtpDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyOtpDtoBuilder toBuilder() => VerifyOtpDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyOtpDto && email == other.email && otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyOtpDto')
          ..add('email', email)
          ..add('otp', otp))
        .toString();
  }
}

class VerifyOtpDtoBuilder
    implements Builder<VerifyOtpDto, VerifyOtpDtoBuilder> {
  _$VerifyOtpDto? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  VerifyOtpDtoBuilder() {
    VerifyOtpDto._defaults(this);
  }

  VerifyOtpDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyOtpDto other) {
    _$v = other as _$VerifyOtpDto;
  }

  @override
  void update(void Function(VerifyOtpDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyOtpDto build() => _build();

  _$VerifyOtpDto _build() {
    final _$result = _$v ??
        _$VerifyOtpDto._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'VerifyOtpDto', 'email'),
          otp: BuiltValueNullFieldError.checkNotNull(
              otp, r'VerifyOtpDto', 'otp'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
