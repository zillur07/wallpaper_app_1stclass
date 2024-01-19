import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/model/catagory.dart';
import 'package:app_name/src/page/category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatagpryComponent extends StatelessWidget {
  final WallpaperController controller = Get.find();
  CatagpryComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
                mainAxisExtent: 200.0),
            itemCount: controller.categoryModelList.length,
            itemBuilder: (BuildContext context, int index) {
              final category = controller.categoryModelList[index];
              return GestureDetector(
                onTap: () async {
                  await controller.fetchWallpapersSearch1(category.catName);
                  Get.to(CategoryPage(
                    categoryModel: category,
                  ));
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          // child: Image.asset(
                          //   '${item.catImgUrl}',
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image.network(
                            '${category.catImgUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          height: 50,
                          width: Get.width - 200,
                          child: Center(
                            child: Text(
                              '${category.catName}',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
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
        ],
      ),
    );
  }
}
