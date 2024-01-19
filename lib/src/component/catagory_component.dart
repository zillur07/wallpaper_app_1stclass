import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/category_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatagpryComponent extends StatelessWidget {
  const CatagpryComponent({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(
      builder: (controller) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 2.0,
                  mainAxisExtent: 150.0,
                ),
                itemCount: controller.categoryModelList.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = controller.categoryModelList[index];
                  return InkWell(
                    onTap: () async {
                      await controller.fetchWallpapersSearch1(category.catName);
                      Get.to(
                        CategoryPage(categoryModel: category),
                        transition: Transition.rightToLeftWithFade,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            width: Get.width - 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              // child: Image.network(
                              //   category.catImgUrl,
                              //   fit: BoxFit.cover,
                              // ),
                              child: CachedNetworkImage(
                                imageUrl: category.catImgUrl,
                                fit: BoxFit.cover,
                                placeholder:
                                    (BuildContext context, String url) =>
                                        Container(
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                color: Colors.black.withOpacity(0.4),
                              ),
                              height: 50,
                              width: Get.width - 212,
                              child: Center(
                                child: Text(
                                  category.catName,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
