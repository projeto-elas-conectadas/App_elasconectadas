import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  // Caminho relativo saindo do front e buscando o arquivo que está na raiz do back-end
  inputSpec: OpenapiInputSpec(filepath: '../Elas_Conectadas_BackEnd/openapi-spec.json'),
  generatorName: Generator.dio, // Usa o cliente HTTP 'Dio', muito comum no Flutter
  outputDirectory: 'lib/generated/api', // Onde o código gerado vai ser salvo
)
class ApiConfig {}