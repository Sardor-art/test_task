import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/data/model/posts_response.dart';
import 'package:test_task/provider/api_client.dart';

class PostController extends GetxController {
  final ApiClient _apiClient = ApiClient.getInstance();

  final List<PostsResponse> _posts = [];

  bool _isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future<void> getPosts() async {
    try {
      isLoading = true;
      _posts.clear();
      _posts.addAll(await _apiClient.getPosts());

      isLoading = false;
    } catch (e) {
      debugPrint('$e');
    }
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  get posts => _posts;
}
