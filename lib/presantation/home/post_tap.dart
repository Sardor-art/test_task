import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/post_controller.dart';

import 'widget/posts_item.dart';

class PostTap extends StatelessWidget {
  const PostTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Posts',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ctrl.getPosts();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
          body: Stack(
            children: [
              Visibility(
                visible: ctrl.isLoading,
                child: const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
              ListView.separated(
                itemCount: ctrl.posts.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                shrinkWrap: true,
                itemBuilder: (_, index) => PostsItem(
                  post: ctrl.posts[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 12),
                  child: Divider(
                    height: 3,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
