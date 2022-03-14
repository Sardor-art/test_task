import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (ctrl) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Image.asset('assets/test.jpg'), const Text('Test task')],
          ),
        );
      },
    );
  }
}
