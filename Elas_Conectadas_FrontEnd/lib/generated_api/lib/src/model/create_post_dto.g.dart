// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePostDto extends CreatePostDto {
  @override
  final String title;
  @override
  final String content;
  @override
  final String type;
  @override
  final String? cover;

  factory _$CreatePostDto([void Function(CreatePostDtoBuilder)? updates]) =>
      (CreatePostDtoBuilder()..update(updates))._build();

  _$CreatePostDto._(
      {required this.title,
      required this.content,
      required this.type,
      this.cover})
      : super._();
  @override
  CreatePostDto rebuild(void Function(CreatePostDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePostDtoBuilder toBuilder() => CreatePostDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePostDto &&
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
    return (newBuiltValueToStringHelper(r'CreatePostDto')
          ..add('title', title)
          ..add('content', content)
          ..add('type', type)
          ..add('cover', cover))
        .toString();
  }
}

class CreatePostDtoBuilder
    implements Builder<CreatePostDto, CreatePostDtoBuilder> {
  _$CreatePostDto? _$v;

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

  CreatePostDtoBuilder() {
    CreatePostDto._defaults(this);
  }

  CreatePostDtoBuilder get _$this {
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
  void replace(CreatePostDto other) {
    _$v = other as _$CreatePostDto;
  }

  @override
  void update(void Function(CreatePostDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePostDto build() => _build();

  _$CreatePostDto _build() {
    final _$result = _$v ??
        _$CreatePostDto._(
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'CreatePostDto', 'title'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'CreatePostDto', 'content'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'CreatePostDto', 'type'),
          cover: cover,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
