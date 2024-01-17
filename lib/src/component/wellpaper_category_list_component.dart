import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/single_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellpaperCategoryListComponent extends StatelessWidget {
  final WallpaperController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            print(
                'WallpapersSearchList length: ${controller.wallpapersSearchList.length}');
            return GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        wallpaperData: controller.wallpapersSearchList,
                      ),
                    );
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Image.network(
                      item.src.medium,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
