import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/single_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellpaperSearchComponent extends StatelessWidget {
  // final WallpaperController controller = Get.find();
  final WallpaperController controller = Get.find();

  WellpaperSearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          controller.wallpapersSearchList.isEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                    mainAxisExtent: 350.0,
                  ),
                  itemCount: controller.wallpapers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.wallpapers[index];
                    return InkWell(
                      onTap: () {
                        Get.to(
                          SinglePage(
                            initialPageIndex: index,
                            wallpaperData: controller
                                .wallpapers, // Pass the wallpaper data
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'heroTag_$index', // Use a unique tag
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // child: Image.network(
                          //   item.src.medium,
                          //   fit: BoxFit.cover,
                          // ),

                          child: CachedNetworkImage(
                            imageUrl: item.src.medium,
                            fit: BoxFit.cover,
                            placeholder: (BuildContext context, String url) =>
                                Container(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                      mainAxisExtent: 350.0,
                    ),
                    itemCount: controller.wallpapersSearchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = controller.wallpapersSearchList[index];
                      return InkWell(
                        onTap: () {
                          Get.to(
                            SinglePage(
                              initialPageIndex: index,
                              wallpaperData: controller
                                  .wallpapersSearchList, // Pass the wallpaper data
                            ),
                            transition: Transition.rightToLeftWithFade,
                          );
                        },
                        child: Hero(
                          tag: 'heroTag_$index', // Use a unique tag
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // child: Image.network(
                            //   item.src.medium,
                            //   fit: BoxFit.cover,
                            // ),

                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
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
                ),
        ],
      ),
    );
  }
}
