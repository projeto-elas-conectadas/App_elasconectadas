# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerLogin**](AuthApi.md#authcontrollerlogin) | **POST** /auth/login | 
[**authControllerRequestOTP**](AuthApi.md#authcontrollerrequestotp) | **POST** /auth/request-otp | 
[**authControllerSendMail**](AuthApi.md#authcontrollersendmail) | **POST** /auth/send | 
[**authControllerVerifyOTP**](AuthApi.md#authcontrollerverifyotp) | **POST** /auth/verify-otp | 


# **authControllerLogin**
> authControllerLogin()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();

try {
    api.authControllerLogin();
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerLogin: $e\n');
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

# **authControllerRequestOTP**
> authControllerRequestOTP(body)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final JsonObject body = Object; // JsonObject | 

try {
    api.authControllerRequestOTP(body);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerRequestOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **JsonObject**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerSendMail**
> authControllerSendMail(body)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final JsonObject body = Object; // JsonObject | 

try {
    api.authControllerSendMail(body);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerSendMail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **JsonObject**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerVerifyOTP**
> authControllerVerifyOTP(body)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final JsonObject body = Object; // JsonObject | 

try {
    api.authControllerVerifyOTP(body);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerVerifyOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **JsonObject**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

