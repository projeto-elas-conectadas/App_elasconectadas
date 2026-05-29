# openapi.api.ProdutosApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**produtosCreate**](ProdutosApi.md#produtoscreate) | **POST** /produtos | Cria um novo produto
[**produtosFindAll**](ProdutosApi.md#produtosfindall) | **GET** /produtos | Lista todos os produtos
[**produtosFindOne**](ProdutosApi.md#produtosfindone) | **GET** /produtos/{id} | Busca um produto por ID


# **produtosCreate**
> produtosCreate(createProdutoDto)

Cria um novo produto

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProdutosApi();
final CreateProdutoDto createProdutoDto = ; // CreateProdutoDto | 

try {
    api.produtosCreate(createProdutoDto);
} on DioException catch (e) {
    print('Exception when calling ProdutosApi->produtosCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProdutoDto** | [**CreateProdutoDto**](CreateProdutoDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **produtosFindAll**
> produtosFindAll()

Lista todos os produtos

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProdutosApi();

try {
    api.produtosFindAll();
} on DioException catch (e) {
    print('Exception when calling ProdutosApi->produtosFindAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **produtosFindOne**
> produtosFindOne(id)

Busca um produto por ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProdutosApi();
final String id = id_example; // String | 

try {
    api.produtosFindOne(id);
} on DioException catch (e) {
    print('Exception when calling ProdutosApi->produtosFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

