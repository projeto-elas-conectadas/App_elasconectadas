// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProdutoResponseDto extends ProdutoResponseDto {
  @override
  final String id;
  @override
  final String nome;
  @override
  final String descricao;
  @override
  final String preco;
  @override
  final String categoria;
  @override
  final String imagemPrincipal;
  @override
  final BuiltList<String>? imagensAdicionais;
  @override
  final String userId;
  @override
  final String regiaoAtendimento;
  @override
  final DateTime criadoEm;

  factory _$ProdutoResponseDto(
          [void Function(ProdutoResponseDtoBuilder)? updates]) =>
      (ProdutoResponseDtoBuilder()..update(updates))._build();

  _$ProdutoResponseDto._(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.preco,
      required this.categoria,
      required this.imagemPrincipal,
      this.imagensAdicionais,
      required this.userId,
      required this.regiaoAtendimento,
      required this.criadoEm})
      : super._();
  @override
  ProdutoResponseDto rebuild(
          void Function(ProdutoResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProdutoResponseDtoBuilder toBuilder() =>
      ProdutoResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProdutoResponseDto &&
        id == other.id &&
        nome == other.nome &&
        descricao == other.descricao &&
        preco == other.preco &&
        categoria == other.categoria &&
        imagemPrincipal == other.imagemPrincipal &&
        imagensAdicionais == other.imagensAdicionais &&
        userId == other.userId &&
        regiaoAtendimento == other.regiaoAtendimento &&
        criadoEm == other.criadoEm;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, nome.hashCode);
    _$hash = $jc(_$hash, descricao.hashCode);
    _$hash = $jc(_$hash, preco.hashCode);
    _$hash = $jc(_$hash, categoria.hashCode);
    _$hash = $jc(_$hash, imagemPrincipal.hashCode);
    _$hash = $jc(_$hash, imagensAdicionais.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, regiaoAtendimento.hashCode);
    _$hash = $jc(_$hash, criadoEm.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProdutoResponseDto')
          ..add('id', id)
          ..add('nome', nome)
          ..add('descricao', descricao)
          ..add('preco', preco)
          ..add('categoria', categoria)
          ..add('imagemPrincipal', imagemPrincipal)
          ..add('imagensAdicionais', imagensAdicionais)
          ..add('userId', userId)
          ..add('regiaoAtendimento', regiaoAtendimento)
          ..add('criadoEm', criadoEm))
        .toString();
  }
}

class ProdutoResponseDtoBuilder
    implements Builder<ProdutoResponseDto, ProdutoResponseDtoBuilder> {
  _$ProdutoResponseDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _nome;
  String? get nome => _$this._nome;
  set nome(String? nome) => _$this._nome = nome;

  String? _descricao;
  String? get descricao => _$this._descricao;
  set descricao(String? descricao) => _$this._descricao = descricao;

  String? _preco;
  String? get preco => _$this._preco;
  set preco(String? preco) => _$this._preco = preco;

  String? _categoria;
  String? get categoria => _$this._categoria;
  set categoria(String? categoria) => _$this._categoria = categoria;

  String? _imagemPrincipal;
  String? get imagemPrincipal => _$this._imagemPrincipal;
  set imagemPrincipal(String? imagemPrincipal) =>
      _$this._imagemPrincipal = imagemPrincipal;

  ListBuilder<String>? _imagensAdicionais;
  ListBuilder<String> get imagensAdicionais =>
      _$this._imagensAdicionais ??= ListBuilder<String>();
  set imagensAdicionais(ListBuilder<String>? imagensAdicionais) =>
      _$this._imagensAdicionais = imagensAdicionais;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _regiaoAtendimento;
  String? get regiaoAtendimento => _$this._regiaoAtendimento;
  set regiaoAtendimento(String? regiaoAtendimento) =>
      _$this._regiaoAtendimento = regiaoAtendimento;

  DateTime? _criadoEm;
  DateTime? get criadoEm => _$this._criadoEm;
  set criadoEm(DateTime? criadoEm) => _$this._criadoEm = criadoEm;

  ProdutoResponseDtoBuilder() {
    ProdutoResponseDto._defaults(this);
  }

  ProdutoResponseDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _nome = $v.nome;
      _descricao = $v.descricao;
      _preco = $v.preco;
      _categoria = $v.categoria;
      _imagemPrincipal = $v.imagemPrincipal;
      _imagensAdicionais = $v.imagensAdicionais?.toBuilder();
      _userId = $v.userId;
      _regiaoAtendimento = $v.regiaoAtendimento;
      _criadoEm = $v.criadoEm;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProdutoResponseDto other) {
    _$v = other as _$ProdutoResponseDto;
  }

  @override
  void update(void Function(ProdutoResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProdutoResponseDto build() => _build();

  _$ProdutoResponseDto _build() {
    _$ProdutoResponseDto _$result;
    try {
      _$result = _$v ??
          _$ProdutoResponseDto._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'ProdutoResponseDto', 'id'),
            nome: BuiltValueNullFieldError.checkNotNull(
                nome, r'ProdutoResponseDto', 'nome'),
            descricao: BuiltValueNullFieldError.checkNotNull(
                descricao, r'ProdutoResponseDto', 'descricao'),
            preco: BuiltValueNullFieldError.checkNotNull(
                preco, r'ProdutoResponseDto', 'preco'),
            categoria: BuiltValueNullFieldError.checkNotNull(
                categoria, r'ProdutoResponseDto', 'categoria'),
            imagemPrincipal: BuiltValueNullFieldError.checkNotNull(
                imagemPrincipal, r'ProdutoResponseDto', 'imagemPrincipal'),
            imagensAdicionais: _imagensAdicionais?.build(),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'ProdutoResponseDto', 'userId'),
            regiaoAtendimento: BuiltValueNullFieldError.checkNotNull(
                regiaoAtendimento, r'ProdutoResponseDto', 'regiaoAtendimento'),
            criadoEm: BuiltValueNullFieldError.checkNotNull(
                criadoEm, r'ProdutoResponseDto', 'criadoEm'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imagensAdicionais';
        _imagensAdicionais?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ProdutoResponseDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
