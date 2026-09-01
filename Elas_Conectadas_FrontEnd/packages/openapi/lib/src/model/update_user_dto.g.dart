// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserDto extends UpdateUserDto {
  @override
  final String? name;
  @override
  final String? phone;
  @override
  final String? occupation;
  @override
  final String? bio;
  @override
  final String? pfp;
  @override
  final String? rua;
  @override
  final String? numero;
  @override
  final String? bairro;
  @override
  final String? cidade;
  @override
  final String? estado;

  factory _$UpdateUserDto([void Function(UpdateUserDtoBuilder)? updates]) =>
      (UpdateUserDtoBuilder()..update(updates))._build();

  _$UpdateUserDto._(
      {this.name,
      this.phone,
      this.occupation,
      this.bio,
      this.pfp,
      this.rua,
      this.numero,
      this.bairro,
      this.cidade,
      this.estado})
      : super._();
  @override
  UpdateUserDto rebuild(void Function(UpdateUserDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateUserDtoBuilder toBuilder() => UpdateUserDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserDto &&
        name == other.name &&
        phone == other.phone &&
        occupation == other.occupation &&
        bio == other.bio &&
        pfp == other.pfp &&
        rua == other.rua &&
        numero == other.numero &&
        bairro == other.bairro &&
        cidade == other.cidade &&
        estado == other.estado;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, occupation.hashCode);
    _$hash = $jc(_$hash, bio.hashCode);
    _$hash = $jc(_$hash, pfp.hashCode);
    _$hash = $jc(_$hash, rua.hashCode);
    _$hash = $jc(_$hash, numero.hashCode);
    _$hash = $jc(_$hash, bairro.hashCode);
    _$hash = $jc(_$hash, cidade.hashCode);
    _$hash = $jc(_$hash, estado.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserDto')
          ..add('name', name)
          ..add('phone', phone)
          ..add('occupation', occupation)
          ..add('bio', bio)
          ..add('pfp', pfp)
          ..add('rua', rua)
          ..add('numero', numero)
          ..add('bairro', bairro)
          ..add('cidade', cidade)
          ..add('estado', estado))
        .toString();
  }
}

class UpdateUserDtoBuilder
    implements Builder<UpdateUserDto, UpdateUserDtoBuilder> {
  _$UpdateUserDto? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _occupation;
  String? get occupation => _$this._occupation;
  set occupation(String? occupation) => _$this._occupation = occupation;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  String? _pfp;
  String? get pfp => _$this._pfp;
  set pfp(String? pfp) => _$this._pfp = pfp;

  String? _rua;
  String? get rua => _$this._rua;
  set rua(String? rua) => _$this._rua = rua;

  String? _numero;
  String? get numero => _$this._numero;
  set numero(String? numero) => _$this._numero = numero;

  String? _bairro;
  String? get bairro => _$this._bairro;
  set bairro(String? bairro) => _$this._bairro = bairro;

  String? _cidade;
  String? get cidade => _$this._cidade;
  set cidade(String? cidade) => _$this._cidade = cidade;

  String? _estado;
  String? get estado => _$this._estado;
  set estado(String? estado) => _$this._estado = estado;

  UpdateUserDtoBuilder() {
    UpdateUserDto._defaults(this);
  }

  UpdateUserDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _phone = $v.phone;
      _occupation = $v.occupation;
      _bio = $v.bio;
      _pfp = $v.pfp;
      _rua = $v.rua;
      _numero = $v.numero;
      _bairro = $v.bairro;
      _cidade = $v.cidade;
      _estado = $v.estado;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserDto other) {
    _$v = other as _$UpdateUserDto;
  }

  @override
  void update(void Function(UpdateUserDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserDto build() => _build();

  _$UpdateUserDto _build() {
    final _$result = _$v ??
        _$UpdateUserDto._(
          name: name,
          phone: phone,
          occupation: occupation,
          bio: bio,
          pfp: pfp,
          rua: rua,
          numero: numero,
          bairro: bairro,
          cidade: cidade,
          estado: estado,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
