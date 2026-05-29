// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ad_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAdDto extends CreateAdDto {
  @override
  final String title;
  @override
  final String content;
  @override
  final String type;
  @override
  final String? cover;

  factory _$CreateAdDto([void Function(CreateAdDtoBuilder)? updates]) =>
      (CreateAdDtoBuilder()..update(updates))._build();

  _$CreateAdDto._(
      {required this.title,
      required this.content,
      required this.type,
      this.cover})
      : super._();
  @override
  CreateAdDto rebuild(void Function(CreateAdDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAdDtoBuilder toBuilder() => CreateAdDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAdDto &&
        title == other.title &&
        content == other.content &&
        type == other.type &&
        cover == other.cover;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, cover.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAdDto')
          ..add('title', title)
          ..add('content', content)
          ..add('type', type)
          ..add('cover', cover))
        .toString();
  }
}

class CreateAdDtoBuilder implements Builder<CreateAdDto, CreateAdDtoBuilder> {
  _$CreateAdDto? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _cover;
  String? get cover => _$this._cover;
  set cover(String? cover) => _$this._cover = cover;

  CreateAdDtoBuilder() {
    CreateAdDto._defaults(this);
  }

  CreateAdDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _type = $v.type;
      _cover = $v.cover;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAdDto other) {
    _$v = other as _$CreateAdDto;
  }

  @override
  void update(void Function(CreateAdDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAdDto build() => _build();

  _$CreateAdDto _build() {
    final _$result = _$v ??
        _$CreateAdDto._(
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'CreateAdDto', 'title'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'CreateAdDto', 'content'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'CreateAdDto', 'type'),
          cover: cover,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
