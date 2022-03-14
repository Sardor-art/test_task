import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/home_controller.dart';
import 'package:test_task/presantation/home/photo_tap.dart';
import 'package:test_task/presantation/home/post_tap.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          body: IndexedStack(
            index: ctrl.currentIndex,
            children: const [
              PostTap(),
              PhotoTap(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              ctrl.currentIndex = index;
            },
            currentIndex: ctrl.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add_sharp),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image),
                label: 'Images',
              ),
            ],
          ),
        );
      },
    );
  }
}
