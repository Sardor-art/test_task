import 'package:get/get.dart';
import 'package:test_task/controller/home_controller.dart';
import 'package:test_task/controller/photo_controller.dart';
import 'package:test_task/controller/post_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.lazyPut(
      () => PostController(),
      fenix: true,
    );
    Get.lazyPut(
      () => PhotoController(),
      fenix: true,
    );
  }
}
