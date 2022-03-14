import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/photo_controller.dart';

class PhotoTap extends StatelessWidget {
  const PhotoTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Photos',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ctrl.getPhotos();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
          body: ctrl.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: Get.height,
                        autoPlay: true,
                        viewportFraction: 1,
                      ),
                      items: [0, 1, 2, 3].map((i) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: ctrl.images[i].url ?? '',
                              height: Get.width / 2,
                              width: Get.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Text(
                              ctrl.images[0].title ?? 's',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'album id: ' + ctrl.images[0].albumId.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
