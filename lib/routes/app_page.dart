import 'package:get/get.dart';
import 'package:test_task/binding/home_binding.dart';
import 'package:test_task/binding/splash_binding.dart';
import 'package:test_task/binding/user_binding.dart';
import 'package:test_task/presantation/home/home_page.dart';
import 'package:test_task/presantation/splash/splash_page.dart';
import 'package:test_task/presantation/user_details/user_details.dart';
import 'package:test_task/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.user,
      page: () => const UserPage(),
      binding: UserBinding(),
    ),
  ];
}
