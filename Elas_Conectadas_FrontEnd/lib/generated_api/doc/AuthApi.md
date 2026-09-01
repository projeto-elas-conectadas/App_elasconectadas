# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.elasconectadas.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerLogin**](AuthApi.md#authcontrollerlogin) | **POST** /auth/login | Autentica a usuária e retorna o token JWT
[**authControllerRequestOTP**](AuthApi.md#authcontrollerrequestotp) | **POST** /auth/request-otp | Solicita um código OTP por e-mail
[**authControllerSendMail**](AuthApi.md#authcontrollersendmail) | **POST** /auth/send | Envia um e-mail transacional
[**authControllerVerifyOTP**](AuthApi.md#authcontrollerverifyotp) | **POST** /auth/verify-otp | Verifica o código OTP informado


# **authControllerLogin**
> LoginResponseDto authControllerLogin(loginDto)

Autentica a usuária e retorna o token JWT

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
> JsonObject authControllerRequestOTP(requestTokenDto)

Solicita um código OTP por e-mail

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final RequestTokenDto requestTokenDto = ; // RequestTokenDto | 

try {
    final response = api.authControllerRequestOTP(requestTokenDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerRequestOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestTokenDto** | [**RequestTokenDto**](RequestTokenDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerSendMail**
> JsonObject authControllerSendMail(sendEmailDto)

Envia um e-mail transacional

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final SendEmailDto sendEmailDto = ; // SendEmailDto | 

try {
    final response = api.authControllerSendMail(sendEmailDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerSendMail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendEmailDto** | [**SendEmailDto**](SendEmailDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerVerifyOTP**
> JsonObject authControllerVerifyOTP(verifyOtpDto)

Verifica o código OTP informado

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAuthApi();
final VerifyOtpDto verifyOtpDto = ; // VerifyOtpDto | 

try {
    final response = api.authControllerVerifyOTP(verifyOtpDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->authControllerVerifyOTP: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyOtpDto** | [**VerifyOtpDto**](VerifyOtpDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

