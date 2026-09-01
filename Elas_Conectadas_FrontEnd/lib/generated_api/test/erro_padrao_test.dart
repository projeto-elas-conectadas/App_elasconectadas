import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

// tests for ErroPadrao
void main() {
  final instance = ErroPadraoBuilder();
  // TODO add properties to the builder and call build()

  group(ErroPadrao, () {
    // Código do status HTTP
    // int statusCode
    test('to test the property `statusCode`', () async {
      // TODO
    });

    // ErroPadraoMessage message
    test('to test the property `message`', () async {
      // TODO
    });

    // Nome oficial do erro HTTP
    // String error
    test('to test the property `error`', () async {
      // TODO
    });

    // Rota em que o erro ocorreu
    // String path
    test('to test the property `path`', () async {
      // TODO
    });

    // Detalhes do validador OpenAPI, quando existirem
    // BuiltList<BuiltMap<String, JsonObject>> errors
    test('to test the property `errors`', () async {
      // TODO
    });

  });
}
