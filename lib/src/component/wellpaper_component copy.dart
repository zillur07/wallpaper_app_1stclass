// import 'package:app_name/src/model/wallpaper.dart';
// import 'package:app_name/src/page/single_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WellpaperComponent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           GridView.builder(
//             shrinkWrap: true,
//             primary: false,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//                 mainAxisExtent: 250.0),
//             itemCount: wallpaperData.length,
//             itemBuilder: (BuildContext context, int index) {
//               final item = wallpaperData[index];
//               return InkWell(
//                 onTap: () {
//                   Get.to(SinglePage(
//                     // initialPageIndex: index,
//                     initialPageIndex: index,
//                     wallpaperData: wallpaperData,
//                   ));
//                 },
//                 child: Container(
//                   width: 250,
//                   child: Image.asset(
//                     // '${wallpaperData[index].image}',
//                     // '${item.image}',
//                     //item.image.toString(),
//                     wallpaperData[index].image.toString(),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
