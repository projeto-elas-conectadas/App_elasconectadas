// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadResponseDto extends UploadResponseDto {
  @override
  final String imageUrl;

  factory _$UploadResponseDto(
          [void Function(UploadResponseDtoBuilder)? updates]) =>
      (UploadResponseDtoBuilder()..update(updates))._build();

  _$UploadResponseDto._({required this.imageUrl}) : super._();
  @override
  UploadResponseDto rebuild(void Function(UploadResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UploadResponseDtoBuilder toBuilder() =>
      UploadResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadResponseDto && imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UploadResponseDto')
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class UploadResponseDtoBuilder
    implements Builder<UploadResponseDto, UploadResponseDtoBuilder> {
  _$UploadResponseDto? _$v;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  UploadResponseDtoBuilder() {
    UploadResponseDto._defaults(this);
  }

  UploadResponseDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadResponseDto other) {
    _$v = other as _$UploadResponseDto;
  }

  @override
  void update(void Function(UploadResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadResponseDto build() => _build();

  _$UploadResponseDto _build() {
    final _$result = _$v ??
        _$UploadResponseDto._(
          imageUrl: BuiltValueNullFieldError.checkNotNull(
              imageUrl, r'UploadResponseDto', 'imageUrl'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
