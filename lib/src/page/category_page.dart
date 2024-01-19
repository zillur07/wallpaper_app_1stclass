// import 'package:app_name/src/component/wellpaper_category_list_component.dart';
// import 'package:app_name/src/component/wellpaper_serach_component.dart';
// import 'package:app_name/src/controllers/wallpaper_controller.dart';
// import 'package:app_name/src/model/catagory.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CategoryPage extends StatelessWidget {
//   final CategoryModel categoryModel;
//   const CategoryPage({Key? key, required this.categoryModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           categoryModel.catName,
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
//         ),
//         actions: [],
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Stack(
//             children: [
//               Image.network(
//                   height: 150,
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.cover,
//                   categoryModel.catImgUrl),
//               Container(
//                 height: 150,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.black38,
//               ),
//               Positioned(
//                 left: 120,
//                 top: 40,
//                 child: Column(
//                   children: [
//                     Text("Category",
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w300)),
//                     Text(
//                       categoryModel.catName,
//                       style: TextStyle(
//                           fontSize: 30,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView(
//                 padding: EdgeInsets.only(top: 5),
//                 shrinkWrap: true,
//                 primary: false,
//                 children: [
//                   WellpaperCategoryListComponent(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:app_name/src/component/wellpaper_category_list_component.dart';
import 'package:app_name/src/model/catagory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  final CategoryModel categoryModel;

  CategoryPage({required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          categoryModel.catName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
        ),
        actions: [],
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  categoryModel.catImgUrl),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.black38,
              ),
              Positioned(
                left: 150,
                top: 40,
                child: Column(
                  children: [
                    Text("Category",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                    Text(
                      categoryModel.catName,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                padding: EdgeInsets.only(top: 5),
                shrinkWrap: true,
                primary: false,
                children: [
                  WellpaperCategoryListComponent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
