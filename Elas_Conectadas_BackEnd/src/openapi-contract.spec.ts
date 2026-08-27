import SwaggerParser from '@apidevtools/swagger-parser';
import { join } from 'path';

describe('Contrato OpenAPI', () => {
  let api: any;

  beforeAll(async () => {
    api = await SwaggerParser.dereference(
      join(process.cwd(), 'api-specs', 'main-api.yaml'),
    );
  });

  it('é uma especificação válida', () => {
    expect(api.openapi).toBe('3.0.0');
    expect(Object.keys(api.paths)).toHaveLength(17);
  });

  it.each([
    ['POST', '/users/register', '201'],
    ['POST', '/produtos', '201'],
    ['GET', '/produtos', '200'],
    ['GET', '/produtos/{id}', '200'],
    ['POST', '/upload/imagem', '201'],
  ])('%s %s possui schema na resposta %s', (method, path, status) => {
    const response = api.paths[path][method.toLowerCase()].responses[status];

    expect(response.content['application/json'].schema).toBeDefined();
  });

  it('exige o arquivo no upload multipart', () => {
    const schema =
      api.paths['/upload/imagem'].post.requestBody.content[
        'multipart/form-data'
      ].schema;

    expect(schema.required).toContain('file');
  });
});
