# openapi.model.ErroPadrao

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**statusCode** | **int** | Código do status HTTP | [optional] 
**message** | [**ErroPadraoMessage**](ErroPadraoMessage.md) |  | [optional] 
**error** | **String** | Nome oficial do erro HTTP | [optional] 
**path** | **String** | Rota em que o erro ocorreu | [optional] 
**errors** | [**BuiltList&lt;BuiltMap&lt;String, JsonObject&gt;&gt;**](BuiltMap.md) | Detalhes do validador OpenAPI, quando existirem | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


