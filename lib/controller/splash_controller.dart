import 'package:get/get.dart';
import 'package:test_task/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 5));
    Get.offAllNamed(Routes.home);
  }
}
