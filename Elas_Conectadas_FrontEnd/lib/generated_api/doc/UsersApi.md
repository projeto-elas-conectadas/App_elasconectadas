# openapi.api.UsersApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://api.elasconectadas.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**usersControllerCreateAdmin**](UsersApi.md#userscontrollercreateadmin) | **POST** /users/admin | Cria uma conta de administradora
[**usersControllerCreateUser**](UsersApi.md#userscontrollercreateuser) | **POST** /users/register | Registra uma nova usuária
[**usersControllerDeleteUserById**](UsersApi.md#userscontrollerdeleteuserbyid) | **DELETE** /users/{id} | Remove uma usuária
[**usersControllerGetUserById**](UsersApi.md#userscontrollergetuserbyid) | **GET** /users/{id} | Busca uma usuária por ID
[**usersControllerGetUsers**](UsersApi.md#userscontrollergetusers) | **GET** /users | Lista todas as usuárias
[**usersControllerUpdateUserById**](UsersApi.md#userscontrollerupdateuserbyid) | **PATCH** /users/{id} | Atualiza os dados da usuária


# **usersControllerCreateAdmin**
> JsonObject usersControllerCreateAdmin(createAdminDto)

Cria uma conta de administradora

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final CreateAdminDto createAdminDto = ; // CreateAdminDto | 

try {
    final response = api.usersControllerCreateAdmin(createAdminDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerCreateAdmin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAdminDto** | [**CreateAdminDto**](CreateAdminDto.md)|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerCreateUser**
> UserResponseDto usersControllerCreateUser(createUserDto)

Registra uma nova usuária

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final CreateUserDto createUserDto = ; // CreateUserDto | 

try {
    final response = api.usersControllerCreateUser(createUserDto);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerCreateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUserDto** | [**CreateUserDto**](CreateUserDto.md)|  | 

### Return type

[**UserResponseDto**](UserResponseDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerDeleteUserById**
> usersControllerDeleteUserById(id)

Remove uma usuária

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final String id = id_example; // String | 

try {
    api.usersControllerDeleteUserById(id);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerDeleteUserById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerGetUserById**
> UserResponseDto usersControllerGetUserById(id)

Busca uma usuária por ID

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final String id = id_example; // String | 

try {
    final response = api.usersControllerGetUserById(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetUserById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**UserResponseDto**](UserResponseDto.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerGetUsers**
> BuiltList<UserResponseDto> usersControllerGetUsers()

Lista todas as usuárias

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();

try {
    final response = api.usersControllerGetUsers();
    print(response);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetUsers: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;UserResponseDto&gt;**](UserResponseDto.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerUpdateUserById**
> usersControllerUpdateUserById(id, updateUserDto)

Atualiza os dados da usuária

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final String id = id_example; // String | 
final UpdateUserDto updateUserDto = ; // UpdateUserDto | 

try {
    api.usersControllerUpdateUserById(id, updateUserDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerUpdateUserById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateUserDto** | [**UpdateUserDto**](UpdateUserDto.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

