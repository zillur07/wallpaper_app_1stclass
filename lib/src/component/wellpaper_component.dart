import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/single_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellpaperComponent extends StatelessWidget {
  final WallpaperController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    Get.to(SinglePage(
                      initialPageIndex: index,
                      wallpaperData:
                          controller.wallpapers, // Pass the wallpaper data
                    ));
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    // child: Image.network(
                    //   controller.wallpapers[index].src.medium,
                    //   fit: BoxFit.cover,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: controller.wallpapers[index].src.medium,
                      fit: BoxFit.cover,
                      placeholder: (BuildContext context, String url) =>
                          Container(
                        color: Colors.pink,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
