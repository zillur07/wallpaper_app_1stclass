import 'package:app_name/src/model/wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SinglePage extends StatelessWidget {
  final WallpaperModel wallpaper;

  SinglePage({required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wallpaper.name.toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: Image.asset(
              '${wallpaper.image}',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 15,
            left: 130,
            right: 130,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.download,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// import 'package:app_name/src/model/wallpaper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';

// class SinglePage extends StatelessWidget {
//   final WallpaperModel wallpaper;

//   SinglePage({required this.wallpaper});

//   Future<void> _downloadImage() async {
//     try {
//       // Use the image_downloader package to download the image
//       var imageId = await ImageDownloader.downloadImage(wallpaper.image!);
//       if (imageId != null) {
//         // You can show a success message or perform other actions here
//         print('Image downloaded with id: $imageId');
//       } else {
//         // Handle case where download failed
//         print('Failed to download image');
//       }
//     } catch (error) {
//       // Handle errors, e.g., show an error message
//       print('Error downloading image: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           wallpaper.name.toString(),
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             height: Get.height,
//             width: Get.width,
//             child: Image.asset(
//               '${wallpaper.image}',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 15,
//             left: 130,
//             right: 130,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.black,
//               ),
//               child: IconButton(
//                 onPressed: _downloadImage,
//                 icon: Icon(
//                   Icons.download,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:app_name/src/model/wallpaper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:permission_handler/permission_handler.dart';

// class SinglePage extends StatelessWidget {
//   final WallpaperModel wallpaper;

//   SinglePage({required this.wallpaper});

//   Future<void> _downloadImage() async {
//     // Check if the permission is granted
//     var status = await Permission.storage.status;
//     if (status.isGranted) {
//       try {
//         // Use the image_downloader package to download the image
//         var imageId = await ImageDownloader.downloadImage(wallpaper.image!);
//         if (imageId != null) {
//           // You can show a success message or perform other actions here
//           print('Image downloaded with id: $imageId');
//         } else {
//           // Handle case where download failed
//           print('Failed to download image');
//         }
//       } catch (error) {
//         // Handle errors, e.g., show an error message
//         print('Error downloading image: $error');
//       }
//     } else {
//       // If permission is not granted, request it
//       var result = await Permission.storage.request();
//       if (result.isGranted) {
//         // Permission granted, proceed with image download
//         try {
//           var imageId = await ImageDownloader.downloadImage(wallpaper.image!);
//           if (imageId != null) {
//             // You can show a success message or perform other actions here
//             print('Image downloaded with id: $imageId');
//           } else {
//             // Handle case where download failed
//             print('Failed to download image');
//           }
//         } catch (error) {
//           // Handle errors, e.g., show an error message
//           print('Error downloading image: $error');
//         }
//       } else {
//         // Permission not granted by the user
//         print('Permission not granted by the user');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           wallpaper.name.toString(),
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             height: Get.height,
//             width: Get.width,
//             child: Image.asset(
//               '${wallpaper.image}',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 15,
//             left: 130,
//             right: 130,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.black,
//               ),
//               child: IconButton(
//                 onPressed: _downloadImage,
//                 icon: Icon(
//                   Icons.download,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
