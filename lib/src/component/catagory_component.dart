import 'package:app_name/src/model/catagory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatagpryComponent extends StatelessWidget {
  const CatagpryComponent({super.key});

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
            itemCount: wallpaperCatagoryData.length,
            itemBuilder: (BuildContext context, int index) {
              final item = wallpaperCatagoryData[index];
              return Padding(
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
                        child: Image.asset(
                          '${item.image}',
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
                            '${item.name}',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
