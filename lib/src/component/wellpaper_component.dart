import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/single_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellpaperComponent extends StatelessWidget {
  final WallpaperController controller = Get.find();

  WellpaperComponent({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              controller.wallpapers.isEmpty
                  ? const Column(
                      children: [
                        SizedBox(
                          height: 270,
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 1.0,
                        mainAxisExtent: 350.0,
                      ),
                      itemCount: controller.wallpapers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.wallpapers[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              SinglePage(
                                initialPageIndex: index,
                                wallpaperData: controller.wallpapers,
                              ),
                              transition: Transition.native,
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Hero(
                              tag: 'heroTag_$index', // Use a unique tag
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.src.medium,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (BuildContext context, String url) =>
                                          Container(
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
