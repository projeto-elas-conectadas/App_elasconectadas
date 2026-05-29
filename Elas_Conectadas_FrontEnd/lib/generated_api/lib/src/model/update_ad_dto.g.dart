// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_ad_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAdDto extends UpdateAdDto {
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? type;
  @override
  final String? cover;

  factory _$UpdateAdDto([void Function(UpdateAdDtoBuilder)? updates]) =>
      (UpdateAdDtoBuilder()..update(updates))._build();

  _$UpdateAdDto._({this.title, this.content, this.type, this.cover})
      : super._();
  @override
  UpdateAdDto rebuild(void Function(UpdateAdDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAdDtoBuilder toBuilder() => UpdateAdDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAdDto &&
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
    return (newBuiltValueToStringHelper(r'UpdateAdDto')
          ..add('title', title)
          ..add('content', content)
          ..add('type', type)
          ..add('cover', cover))
        .toString();
  }
}

class UpdateAdDtoBuilder implements Builder<UpdateAdDto, UpdateAdDtoBuilder> {
  _$UpdateAdDto? _$v;

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

  UpdateAdDtoBuilder() {
    UpdateAdDto._defaults(this);
  }

  UpdateAdDtoBuilder get _$this {
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
  void replace(UpdateAdDto other) {
    _$v = other as _$UpdateAdDto;
  }

  @override
  void update(void Function(UpdateAdDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAdDto build() => _build();

  _$UpdateAdDto _build() {
    final _$result = _$v ??
        _$UpdateAdDto._(
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
