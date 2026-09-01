// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_produto_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateProdutoDto extends CreateProdutoDto {
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

  factory _$CreateProdutoDto(
          [void Function(CreateProdutoDtoBuilder)? updates]) =>
      (CreateProdutoDtoBuilder()..update(updates))._build();

  _$CreateProdutoDto._(
      {required this.nome,
      required this.descricao,
      required this.preco,
      required this.categoria,
      required this.imagemPrincipal,
      this.imagensAdicionais,
      required this.userId,
      required this.regiaoAtendimento})
      : super._();
  @override
  CreateProdutoDto rebuild(void Function(CreateProdutoDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateProdutoDtoBuilder toBuilder() =>
      CreateProdutoDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateProdutoDto &&
        nome == other.nome &&
        descricao == other.descricao &&
        preco == other.preco &&
        categoria == other.categoria &&
        imagemPrincipal == other.imagemPrincipal &&
        imagensAdicionais == other.imagensAdicionais &&
        userId == other.userId &&
        regiaoAtendimento == other.regiaoAtendimento;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nome.hashCode);
    _$hash = $jc(_$hash, descricao.hashCode);
    _$hash = $jc(_$hash, preco.hashCode);
    _$hash = $jc(_$hash, categoria.hashCode);
    _$hash = $jc(_$hash, imagemPrincipal.hashCode);
    _$hash = $jc(_$hash, imagensAdicionais.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, regiaoAtendimento.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateProdutoDto')
          ..add('nome', nome)
          ..add('descricao', descricao)
          ..add('preco', preco)
          ..add('categoria', categoria)
          ..add('imagemPrincipal', imagemPrincipal)
          ..add('imagensAdicionais', imagensAdicionais)
          ..add('userId', userId)
          ..add('regiaoAtendimento', regiaoAtendimento))
        .toString();
  }
}

class CreateProdutoDtoBuilder
    implements Builder<CreateProdutoDto, CreateProdutoDtoBuilder> {
  _$CreateProdutoDto? _$v;

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

  CreateProdutoDtoBuilder() {
    CreateProdutoDto._defaults(this);
  }

  CreateProdutoDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nome = $v.nome;
      _descricao = $v.descricao;
      _preco = $v.preco;
      _categoria = $v.categoria;
      _imagemPrincipal = $v.imagemPrincipal;
      _imagensAdicionais = $v.imagensAdicionais?.toBuilder();
      _userId = $v.userId;
      _regiaoAtendimento = $v.regiaoAtendimento;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateProdutoDto other) {
    _$v = other as _$CreateProdutoDto;
  }

  @override
  void update(void Function(CreateProdutoDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateProdutoDto build() => _build();

  _$CreateProdutoDto _build() {
    _$CreateProdutoDto _$result;
    try {
      _$result = _$v ??
          _$CreateProdutoDto._(
            nome: BuiltValueNullFieldError.checkNotNull(
                nome, r'CreateProdutoDto', 'nome'),
            descricao: BuiltValueNullFieldError.checkNotNull(
                descricao, r'CreateProdutoDto', 'descricao'),
            preco: BuiltValueNullFieldError.checkNotNull(
                preco, r'CreateProdutoDto', 'preco'),
            categoria: BuiltValueNullFieldError.checkNotNull(
                categoria, r'CreateProdutoDto', 'categoria'),
            imagemPrincipal: BuiltValueNullFieldError.checkNotNull(
                imagemPrincipal, r'CreateProdutoDto', 'imagemPrincipal'),
            imagensAdicionais: _imagensAdicionais?.build(),
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'CreateProdutoDto', 'userId'),
            regiaoAtendimento: BuiltValueNullFieldError.checkNotNull(
                regiaoAtendimento, r'CreateProdutoDto', 'regiaoAtendimento'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imagensAdicionais';
        _imagensAdicionais?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateProdutoDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
