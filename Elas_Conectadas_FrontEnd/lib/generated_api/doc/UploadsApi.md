# openapi.api.UploadsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**uploadControllerUploadImagem**](UploadsApi.md#uploadcontrolleruploadimagem) | **POST** /upload/imagem | 


# **uploadControllerUploadImagem**
> uploadControllerUploadImagem(file)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUploadsApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | Arquivo de imagem a ser enviado

try {
    api.uploadControllerUploadImagem(file);
} on DioException catch (e) {
    print('Exception when calling UploadsApi->uploadControllerUploadImagem: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**| Arquivo de imagem a ser enviado | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

