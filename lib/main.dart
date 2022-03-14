import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:test_task/data/constants.dart';

import 'binding/splash_binding.dart';
import 'routes/app_page.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Test Task",
        initialBinding: SplashBinding(),
        navigatorKey: Constants.keys,
        initialRoute: Routes.initial,
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.pages,
        transitionDuration: const Duration(milliseconds: 100),
      ),
    );
  }
}
