import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/category_page.dart';
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
                    onTap: () {
                      Get.to(CategoryPage(categoryModel: category));
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
                            width: Get.width - 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                category.catImgUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.4),
                              ),
                              height: 50,
                              width: Get.width - 200,
                              child: Center(
                                child: Text(
                                  category.catName,
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
