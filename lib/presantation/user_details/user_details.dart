import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/user_controller.dart';

import 'widget/user_item.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              ctrl.user?.name ?? 'User info',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ctrl.getUser();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
          body: ctrl.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : UserItem(
                  phone: ctrl.phone.text,
                  user: ctrl.user,
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.dialog(
                Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: ctrl.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: ctrl.save,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
