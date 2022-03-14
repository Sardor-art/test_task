import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/data/model/posts_response.dart';
import 'package:test_task/routes/app_routes.dart';

class PostsItem extends StatelessWidget {
  final PostsResponse post;

  const PostsItem({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${post.id}: ${post.title}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          post.body ?? '',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: MaterialButton(
            color: Colors.blue,
            minWidth: Get.width,
            onPressed: () {
              Get.toNamed(
                Routes.user,
                arguments: post.userId,
              );
            },
            child: Text(
              'User Id: ${post.userId}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
