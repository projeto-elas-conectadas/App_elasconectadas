# openapi.api.PostsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**postsControllerCreatePost**](PostsApi.md#postscontrollercreatepost) | **POST** /posts/create | 
[**postsControllerDeletePostById**](PostsApi.md#postscontrollerdeletepostbyid) | **DELETE** /posts/{id} | 
[**postsControllerGetPostById**](PostsApi.md#postscontrollergetpostbyid) | **GET** /posts/{id} | 
[**postsControllerGetPosts**](PostsApi.md#postscontrollergetposts) | **GET** /posts/list | 
[**postsControllerUpdatePostById**](PostsApi.md#postscontrollerupdatepostbyid) | **PATCH** /posts/{id} | 


# **postsControllerCreatePost**
> postsControllerCreatePost(createPostDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPostsApi();
final CreatePostDto createPostDto = ; // CreatePostDto | 

try {
    api.postsControllerCreatePost(createPostDto);
} on DioException catch (e) {
    print('Exception when calling PostsApi->postsControllerCreatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPostDto** | [**CreatePostDto**](CreatePostDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postsControllerDeletePostById**
> postsControllerDeletePostById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPostsApi();
final String id = id_example; // String | 

try {
    api.postsControllerDeletePostById(id);
} on DioException catch (e) {
    print('Exception when calling PostsApi->postsControllerDeletePostById: $e\n');
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

# **postsControllerGetPostById**
> postsControllerGetPostById(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPostsApi();
final String id = id_example; // String | 

try {
    api.postsControllerGetPostById(id);
} on DioException catch (e) {
    print('Exception when calling PostsApi->postsControllerGetPostById: $e\n');
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

# **postsControllerGetPosts**
> postsControllerGetPosts()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPostsApi();

try {
    api.postsControllerGetPosts();
} on DioException catch (e) {
    print('Exception when calling PostsApi->postsControllerGetPosts: $e\n');
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

# **postsControllerUpdatePostById**
> postsControllerUpdatePostById(id, updatePostDto)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPostsApi();
final String id = id_example; // String | 
final UpdatePostDto updatePostDto = ; // UpdatePostDto | 

try {
    api.postsControllerUpdatePostById(id, updatePostDto);
} on DioException catch (e) {
    print('Exception when calling PostsApi->postsControllerUpdatePostById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updatePostDto** | [**UpdatePostDto**](UpdatePostDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

