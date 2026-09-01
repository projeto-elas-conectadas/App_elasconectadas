import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for ProdutosApi
void main() {
  final instance = Openapi().getProdutosApi();

  group(ProdutosApi, () {
    // Cria um novo produto
    //
    //Future<ProdutoResponseDto> produtosCreate(CreateProdutoDto createProdutoDto) async
    test('test produtosCreate', () async {
      // TODO
    });

    // Lista todos os produtos
    //
    //Future<BuiltList<ProdutoResponseDto>> produtosFindAll() async
    test('test produtosFindAll', () async {
      // TODO
    });

    // Busca um produto por ID
    //
    //Future<ProdutoResponseDto> produtosFindOne(String id) async
    test('test produtosFindOne', () async {
      // TODO
    });

  });
}
