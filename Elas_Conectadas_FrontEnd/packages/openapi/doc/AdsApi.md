# openapi.api.AdsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adsControllerCreateAd**](AdsApi.md#adscontrollercreatead) | **POST** /ads/create | 
[**adsControllerDeleteAdById**](AdsApi.md#adscontrollerdeleteadbyid) | **DELETE** /ads/{id} | 
[**adsControllerGetAdById**](AdsApi.md#adscontrollergetadbyid) | **GET** /ads/{id} | 
[**adsControllerGetAllAds**](AdsApi.md#adscontrollergetallads) | **GET** /ads/list | 
[**adsControllerPatchAd**](AdsApi.md#adscontrollerpatchad) | **PATCH** /ads/{id} | 


# **adsControllerCreateAd**
> adsControllerCreateAd(createAdDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final CreateAdDto createAdDto = ; // CreateAdDto | 

try {
    api.adsControllerCreateAd(createAdDto);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerCreateAd: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAdDto** | [**CreateAdDto**](CreateAdDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adsControllerDeleteAdById**
> adsControllerDeleteAdById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final String id = id_example; // String | 

try {
    api.adsControllerDeleteAdById(id);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerDeleteAdById: $e\n');
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

# **adsControllerGetAdById**
> adsControllerGetAdById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final String id = id_example; // String | 

try {
    api.adsControllerGetAdById(id);
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerGetAdById: $e\n');
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

# **adsControllerGetAllAds**
> adsControllerGetAllAds()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();

try {
    api.adsControllerGetAllAds();
} on DioException catch (e) {
    print('Exception when calling AdsApi->adsControllerGetAllAds: $e\n');
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

# **adsControllerPatchAd**
> adsControllerPatchAd(id, updateAdDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAdsApi();
final String id = id_example; // String | 
final UpdateAdDto updateAdDto = ; // UpdateAdDto | 

try {
    api.adsControllerPatchAd(id, updateAdDto);
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

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

