// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePostDto extends UpdatePostDto {
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? type;
  @override
  final String? cover;

  factory _$UpdatePostDto([void Function(UpdatePostDtoBuilder)? updates]) =>
      (UpdatePostDtoBuilder()..update(updates))._build();

  _$UpdatePostDto._({this.title, this.content, this.type, this.cover})
      : super._();
  @override
  UpdatePostDto rebuild(void Function(UpdatePostDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePostDtoBuilder toBuilder() => UpdatePostDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePostDto &&
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
    return (newBuiltValueToStringHelper(r'UpdatePostDto')
          ..add('title', title)
          ..add('content', content)
          ..add('type', type)
          ..add('cover', cover))
        .toString();
  }
}

class UpdatePostDtoBuilder
    implements Builder<UpdatePostDto, UpdatePostDtoBuilder> {
  _$UpdatePostDto? _$v;

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

  UpdatePostDtoBuilder() {
    UpdatePostDto._defaults(this);
  }

  UpdatePostDtoBuilder get _$this {
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
  void replace(UpdatePostDto other) {
    _$v = other as _$UpdatePostDto;
  }

  @override
  void update(void Function(UpdatePostDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePostDto build() => _build();

  _$UpdatePostDto _build() {
    final _$result = _$v ??
        _$UpdatePostDto._(
          title: title,
          content: content,
          type: type,
          cover: cover,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
