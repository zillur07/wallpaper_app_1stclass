import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/single_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellpaperComponent extends StatelessWidget {
  // final WallpaperController controller = Get.find();
  final WallpaperController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => GridView.builder(
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
                          wallpaperData:
                              controller.wallpapers, // Pass the wallpaper data
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
