import 'package:chuck_interceptor/chuck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_task/data/model/photos_response.dart';
import 'package:test_task/data/model/posts_response.dart';
import 'package:test_task/data/model/user_data_response.dart';

import '../data/constants.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiClient {
  static Chuck alice = Chuck(
    showNotification: true,
    showInspectorOnShake: false,
    darkTheme: false,
    navigatorKey: Constants.keys,
  );

  static get getDio {
    Dio dio = Dio(
      BaseOptions(
        followRedirects: false,
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(alice.getDioInterceptor());
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          request: true,
        ),
      );
    }
    return dio;
  }

  static CancelToken cancelToken = CancelToken();

  static ApiClient? _apiClient;

  static ApiClient getInstance({String baseUrl = Constants.baseUrl}) {
    if (_apiClient != null) {
      return _apiClient!;
    } else {
      _apiClient = ApiClient(
        getDio,
        cancelToken,
        baseUrl,
      );
    }
    return _apiClient!;
  }

  factory ApiClient(Dio dio, CancelToken cancelToken, String baseUrl) {
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('posts') // get post
  Future<List<PostsResponse>> getPosts();

  @GET('users/{id}') // get user
  Future<UserDataResponse> getUser(
    @Path('id') int id,
  );

  @GET('photos') // get photo
  Future<List<PhotosResponse>> getPhoto();
}
