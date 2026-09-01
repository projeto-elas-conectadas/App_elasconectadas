import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for PostsApi
void main() {
  final instance = Openapi().getPostsApi();

  group(PostsApi, () {
    //Future postsControllerCreatePost(CreatePostDto createPostDto) async
    test('test postsControllerCreatePost', () async {
      // TODO
    });

    //Future postsControllerDeletePostById(String id) async
    test('test postsControllerDeletePostById', () async {
      // TODO
    });

    //Future postsControllerGetPostById(String id) async
    test('test postsControllerGetPostById', () async {
      // TODO
    });

    //Future postsControllerGetPosts() async
    test('test postsControllerGetPosts', () async {
      // TODO
    });

    //Future postsControllerUpdatePostById(String id, UpdatePostDto updatePostDto) async
    test('test postsControllerUpdatePostById', () async {
      // TODO
    });

  });
}
