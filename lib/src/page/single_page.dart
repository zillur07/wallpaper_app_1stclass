import 'package:app_name/src/component/ename.dart';
import 'package:app_name/src/model/wallpaper.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loop_page_view/loop_page_view.dart';

import 'dart:typed_data';

class SinglePage extends StatelessWidget {
//.......................................
  final List<Photo> wallpaperData;
  final int initialPageIndex;
  SinglePage({required this.wallpaperData, required this.initialPageIndex});

//..........................................................................

// ...

  Future<void> _downloadImage(int imageItem) async {
    try {
      Photo wallpaper = wallpaperData[imageItem];

      // Fetch the image bytes using Dio
      dio.Response<List<int>> response = await dio.Dio().get<List<int>>(
        wallpaper.src.original,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      Uint8List bytes = Uint8List.fromList(response.data!);

      // Save image to gallery
      var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80, // You can specify the image quality (0 to 100)
      );

      if (result['isSuccess']) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Download successfully ',
            message: 'Image saved Successfully',
            icon: Icon(
              Icons.download,
              color: Colors.white,
            ),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Image save failed
        print('Failed to save image: ${result['error']}');
      }
    } catch (e) {
      // Handle the error
      print('Error saving image: $e');
    }
  }

  // Future<void> setWallpaper() async {
  //   try {
  //     int location = WallpaperManager
  //         .BOTH_SCREEN; // Use BOTH_SCREENS instead of BOTH_SCREEN

  //     // Get the wallpaper URL from the current index
  //     String imageUrl = wallpaperData[initialPageIndex].src.original;

  //     // Download the image using Dio
  //     dio.Response<List<int>> response = await dio.Dio().get<List<int>>(
  //       imageUrl,
  //       options: dio.Options(responseType: dio.ResponseType.bytes),
  //     );

  //     Uint8List bytes = Uint8List.fromList(response.data!);

  //     // Save bytes to a temporary file
  //     final file = await DefaultCacheManager().putFile(
  //       'data:image/jpeg;base64,${bytes.toString()}',
  //       Uint8List.fromList(bytes),
  //     );

  //     // Set wallpaper using WallpaperManager
  //     await WallpaperManager.setWallpaperFromFile(
  //       file.path,
  //       location,
  //     );

  //     print('Wallpaper set successfully');
  //   } catch (e) {
  //     // Handle the error
  //     print('Error setting wallpaper: $e');
  //   }
  // }

  Future<void> setWallpaper(WallpaperType type) async {
    try {
      int location;
      String toastMessage;

      switch (type) {
        case WallpaperType.SetWallpaper:
          location = WallpaperManager.HOME_SCREEN;
          toastMessage = 'Wallpaper set successfully';
          break;
        case WallpaperType.SetLockWallpaper:
          location = WallpaperManager.LOCK_SCREEN;
          toastMessage = 'Lock wallpaper set successfully';
          break;
        case WallpaperType.SetBoth:
          location = WallpaperManager.BOTH_SCREEN;
          toastMessage = 'Both wallpapers set successfully';
          break;
      }

      // Get the wallpaper URL from the current index
      String imageUrl = wallpaperData[initialPageIndex].src.original;

      // Download the image using Dio
      dio.Response<List<int>> response = await dio.Dio().get<List<int>>(
        imageUrl,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      Uint8List bytes = Uint8List.fromList(response.data!);

      // Save bytes to a temporary file
      final file = await DefaultCacheManager().putFile(
        'data:image/jpeg;base64,${bytes.toString()}',
        Uint8List.fromList(bytes),
      );

      // Set wallpaper using WallpaperManager
      await WallpaperManager.setWallpaperFromFile(
        file.path,
        location,
      );

      print(toastMessage);
    } catch (e) {
      // Handle the error
      print('Error setting wallpaper: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wallpaper',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.pink),
        ),
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0, // This removes the shadow from the AppBar
      ),
      extendBodyBehindAppBar: true,
      body: LoopPageView.builder(
        itemCount: wallpaperData.length,
        onPageChanged: (index) {},
        controller: LoopPageController(initialPage: initialPageIndex),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'What would you like to do?',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                setWallpaper(WallpaperType.SetWallpaper);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Set Wallpaper',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setWallpaper(WallpaperType.SetLockWallpaper);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock_outline_rounded,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Set Lock Wallpaper',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setWallpaper(WallpaperType.SetBoth);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_search_sharp,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Set Both',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ElevatedButton(
                            //   onPressed: () {
                            //     Get.back(); // Close the bottom sheet
                            //   },
                            //   child: Text('Close'),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  child: Image.network(
                    wallpaperData[index].src.large,
                    fit: BoxFit.cover,
                  ),
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
                    onPressed: () {
                      _downloadImage(index);
                    },
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
