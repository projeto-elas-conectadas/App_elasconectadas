import 'package:flutter_test/flutter_test.dart';
import 'package:openapi/openapi.dart';

void main() {
  const runIntegration = bool.fromEnvironment('RUN_INTEGRATION');

  test(
    'cliente gerado desserializa a listagem real do backend',
    () async {
      final client = Openapi(
        basePathOverride: 'http://localhost:8080',
        interceptors: const [],
      );

      final response = await client.getProdutosApi().produtosFindAll();

      expect(response.statusCode, 200);
      expect(response.data, isNotNull);
      for (final produto in response.data!) {
        expect(produto.id, isNotEmpty);
        expect(produto.preco, isA<String>());
        expect(produto.regiaoAtendimento, isNotEmpty);
      }
    },
    skip: runIntegration
        ? false
        : 'Defina RUN_INTEGRATION=true e inicie o backend local.',
  );
}
