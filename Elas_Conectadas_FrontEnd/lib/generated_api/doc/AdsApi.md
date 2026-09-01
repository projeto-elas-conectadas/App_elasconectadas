# openapi.api.AdsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.elasconectadas.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adsControllerCreateAd**](AdsApi.md#adscontrollercreatead) | **POST** /ads/create | Cria um novo anúncio
[**adsControllerDeleteAdById**](AdsApi.md#adscontrollerdeleteadbyid) | **DELETE** /ads/{id} | Remove um anúncio
[**adsControllerGetAdById**](AdsApi.md#adscontrollergetadbyid) | **GET** /ads/{id} | Busca um anúncio por ID
[**adsControllerGetAllAds**](AdsApi.md#adscontrollergetallads) | **GET** /ads/list | Lista todos os anúncios
[**adsControllerPatchAd**](AdsApi.md#adscontrollerpatchad) | **PATCH** /ads/{id} | Atualiza um anúncio existente


# **adsControllerCreateAd**
> JsonObject adsControllerCreateAd(createAdDto)

Cria um novo anúncio

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final CreateAdDto createAdDto = ; // CreateAdDto | 

try {
    final response = api.adsControllerCreateAd(createAdDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerCreateAd: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAdDto** | [**CreateAdDto**](CreateAdDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adsControllerDeleteAdById**
> JsonObject adsControllerDeleteAdById(id)

Remove um anúncio

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final String id = id_example; // String | 

try {
    final response = api.adsControllerDeleteAdById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerDeleteAdById: $e\n');
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

# **adsControllerGetAdById**
> JsonObject adsControllerGetAdById(id)

Busca um anúncio por ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final String id = id_example; // String | 

try {
    final response = api.adsControllerGetAdById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerGetAdById: $e\n');
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

# **adsControllerGetAllAds**
> JsonObject adsControllerGetAllAds()

Lista todos os anúncios

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();

try {
    final response = api.adsControllerGetAllAds();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerGetAllAds: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adsControllerPatchAd**
> JsonObject adsControllerPatchAd(id, updateAdDto)

Atualiza um anúncio existente

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final String id = id_example; // String | 
final UpdateAdDto updateAdDto = ; // UpdateAdDto | 

try {
    final response = api.adsControllerPatchAd(id, updateAdDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerPatchAd: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateAdDto** | [**UpdateAdDto**](UpdateAdDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

