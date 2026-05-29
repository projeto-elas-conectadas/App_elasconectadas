# openapi.api.UsersApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**usersControllerCreateAdmin**](UsersApi.md#userscontrollercreateadmin) | **POST** /users/admin | 
[**usersControllerCreateUser**](UsersApi.md#userscontrollercreateuser) | **POST** /users/register | 
[**usersControllerDeleteUserById**](UsersApi.md#userscontrollerdeleteuserbyid) | **DELETE** /users/{id} | 
[**usersControllerGetUserById**](UsersApi.md#userscontrollergetuserbyid) | **GET** /users/{id} | 
[**usersControllerGetUsers**](UsersApi.md#userscontrollergetusers) | **GET** /users | 
[**usersControllerUpdateUserById**](UsersApi.md#userscontrollerupdateuserbyid) | **PATCH** /users/{id} | 


# **usersControllerCreateAdmin**
> usersControllerCreateAdmin(createAdminDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final CreateAdminDto createAdminDto = ; // CreateAdminDto | 

try {
    api.usersControllerCreateAdmin(createAdminDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerCreateAdmin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAdminDto** | [**CreateAdminDto**](CreateAdminDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerCreateUser**
> usersControllerCreateUser(createUserDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final CreateUserDto createUserDto = ; // CreateUserDto | 

try {
    api.usersControllerCreateUser(createUserDto);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerCreateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUserDto** | [**CreateUserDto**](CreateUserDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerDeleteUserById**
> usersControllerDeleteUserById(id)



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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **usersControllerGetUserById**
> usersControllerGetUserById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();
final String id = id_example; // String | 

try {
    api.usersControllerGetUserById(id);
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetUserById: $e\n');
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

# **usersControllerGetUsers**
> usersControllerGetUsers()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUsersApi();

try {
    api.usersControllerGetUsers();
} on DioException catch (e) {
    print('Exception when calling UsersApi->usersControllerGetUsers: $e\n');
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

# **usersControllerUpdateUserById**
> usersControllerUpdateUserById(id, updateUserDto)



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

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

