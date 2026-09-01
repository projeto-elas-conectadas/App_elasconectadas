# openapi.api.ProdutosApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.elasconectadas.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**produtosCreate**](ProdutosApi.md#produtoscreate) | **POST** /produtos | Cria um novo produto
[**produtosFindAll**](ProdutosApi.md#produtosfindall) | **GET** /produtos | Lista todos os produtos
[**produtosFindOne**](ProdutosApi.md#produtosfindone) | **GET** /produtos/{id} | Busca um produto por ID


# **produtosCreate**
> JsonObject produtosCreate(createProdutoDto)

Cria um novo produto

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProdutosApi();
final CreateProdutoDto createProdutoDto = ; // CreateProdutoDto | 

try {
    final response = api.produtosCreate(createProdutoDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProdutosApi->produtosCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProdutoDto** | [**CreateProdutoDto**](CreateProdutoDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **produtosFindAll**
> BuiltList<JsonObject> produtosFindAll()

Lista todos os produtos

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProdutosApi();

try {
    final response = api.produtosFindAll();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProdutosApi->produtosFindAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;JsonObject&gt;**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **produtosFindOne**
> JsonObject produtosFindOne(id)

Busca um produto por ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProdutosApi();
final String id = id_example; // String | 

try {
    final response = api.produtosFindOne(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProdutosApi->produtosFindOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

