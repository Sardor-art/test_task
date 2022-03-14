import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/data/model/user_data_response.dart';
import 'package:test_task/provider/api_client.dart';

class UserController extends GetxController {
  final ApiClient _apiClient = ApiClient.getInstance();

  final TextEditingController _phone = TextEditingController();

  UserDataResponse? _user;

  bool _isLoading = false;

  TextEditingController get phone => _phone;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    try {
      isLoading = true;
      _user = (await _apiClient.getUser(Get.arguments ?? 1));
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

  get user => _user;

  void save() {
    update();
    Get.back();
  }
}
