import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/data/model/photos_response.dart';
import 'package:test_task/provider/api_client.dart';

class PhotoController extends GetxController {
  final ApiClient _apiClient = ApiClient.getInstance();

  final List<PhotosResponse> _images = [];

  bool _isLoading = false;

  final _imageCount = 3;

  @override
  void onInit() {
    super.onInit();
    getPhotos();
  }

  Future<void> getPhotos() async {
    try {
      isLoading = true;

      final response = await _apiClient.getPhoto();
      _images.clear();
      response.sublist(0, 4);
      _images.addAll(response);
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

  List<PhotosResponse> get images => _images;
}
