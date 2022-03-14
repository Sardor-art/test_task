import 'package:get/get.dart';
import 'package:test_task/controller/user_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
  }
}
