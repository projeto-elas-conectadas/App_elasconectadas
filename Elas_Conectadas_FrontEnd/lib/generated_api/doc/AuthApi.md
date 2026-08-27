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
> LoginResponseDto authControllerLogin(loginDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final LoginDto loginDto = ; // LoginDto | 

try {
    final response = api.authControllerLogin(loginDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginDto** | [**LoginDto**](LoginDto.md)|  | 

### Return type

[**LoginResponseDto**](LoginResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerRequestOTP**
> authControllerRequestOTP(requestTokenDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final RequestTokenDto requestTokenDto = ; // RequestTokenDto | 

try {
    api.authControllerRequestOTP(requestTokenDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerRequestOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestTokenDto** | [**RequestTokenDto**](RequestTokenDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerSendMail**
> authControllerSendMail(sendEmailDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final SendEmailDto sendEmailDto = ; // SendEmailDto | 

try {
    api.authControllerSendMail(sendEmailDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerSendMail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendEmailDto** | [**SendEmailDto**](SendEmailDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerVerifyOTP**
> authControllerVerifyOTP(verifyOtpDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final VerifyOtpDto verifyOtpDto = ; // VerifyOtpDto | 

try {
    api.authControllerVerifyOTP(verifyOtpDto);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerVerifyOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyOtpDto** | [**VerifyOtpDto**](VerifyOtpDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

