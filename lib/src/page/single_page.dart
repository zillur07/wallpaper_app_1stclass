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

enum WallpaperType {
  SetWallpaper,
  SetLockWallpaper,
  SetBoth,
}

class SinglePage extends StatefulWidget {
  final List<Photo> wallpaperData;
  late final int initialPageIndex;

  SinglePage({required this.wallpaperData, required this.initialPageIndex});

  @override
  _SinglePageState createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  bool _settingWallpaper = false;

  Future<void> _downloadImage(int imageItem) async {
    try {
      Photo wallpaper = widget.wallpaperData[imageItem];

      dio.Response<List<int>> response = await dio.Dio().get<List<int>>(
        wallpaper.src.original,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      Uint8List bytes = Uint8List.fromList(response.data!);

      var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80,
      );

      if (result['isSuccess']) {
        Get.showSnackbar(
          const GetSnackBar(
            snackPosition: SnackPosition.TOP,
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
        print('Failed to save image: ${result['error']}');
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> setWallpaper(WallpaperType type, int pageIndex) async {
    try {
      setState(() {
        _settingWallpaper = true;
      });

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

      String imageUrl = widget.wallpaperData[pageIndex].src.large2x;

      dio.Response<List<int>> response = await dio.Dio().get<List<int>>(
        imageUrl,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      Uint8List bytes = Uint8List.fromList(response.data!);

      final file = await DefaultCacheManager().putFile(
        'data:image/jpeg;base64,${bytes.toString()}',
        Uint8List.fromList(bytes),
      );

      var result = await WallpaperManager.setWallpaperFromFile(
        file.path,
        location,
      );

      print(toastMessage);
    } catch (e) {
      print('Error setting wallpaper: $e');
    } finally {
      setState(() {
        _settingWallpaper = false;
      });

      Get.back();

      Get.showSnackbar(
        const GetSnackBar(
          snackPosition: SnackPosition.TOP,
          title: 'Set Wellpaper successfully ',
          message: 'Wellpaper Set Successfully',
          icon: Icon(
            Icons.download,
            color: Colors.white,
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void onPageChanged(int index) {
    // Update the initialPageIndex when the page is changed
    setState(() {
      widget.initialPageIndex = index;
    });
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => LoopPageView.builder(
          itemCount: widget.wallpaperData.length,
          // onPageChanged: (index) {},
          onPageChanged: onPageChanged,
          controller: LoopPageController(initialPage: widget.initialPageIndex),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        width: Get.width,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: _settingWallpaper
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.pink),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'What would you like to do?',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        setWallpaper(
                                            WallpaperType.SetWallpaper, index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.pink)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'SET WALLPAPER',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setWallpaper(
                                            WallpaperType.SetLockWallpaper,
                                            index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.pink)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.lock_outline_rounded,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'SET LOCK SCREEN',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setWallpaper(
                                            WallpaperType.SetBoth, index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.pink)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.image_search_sharp,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'SET BOTH SCREEN',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     color: Colors.black,
                                    //   ),
                                    //   child: _settingWallpaper
                                    //       ? CircularProgressIndicator(
                                    //           valueColor:
                                    //               AlwaysStoppedAnimation<Color>(
                                    //                   Colors.pink),
                                    //         )
                                    //       : IconButton(
                                    //           onPressed: () {
                                    //             _downloadImage(index);
                                    //           },
                                    //           icon: Icon(
                                    //             Icons.download,
                                    //             color: Colors.white,
                                    //             size: 30,
                                    //           ),
                                    //         ),
                                    // ),

                                    InkWell(
                                      onTap: () {
                                        _downloadImage(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.pink)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.file_download_outlined,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'SAVE TO MEDIA FOLDER',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
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
                      widget.wallpaperData[index].src.large2x,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 15,
                //   left: 130,
                //   right: 130,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       color: Colors.black,
                //     ),
                //     child: _settingWallpaper
                //         ? CircularProgressIndicator(
                //             valueColor:
                //                 AlwaysStoppedAnimation<Color>(Colors.white),
                //           )
                //         : IconButton(
                //             onPressed: () {
                //               _downloadImage(index);
                //             },
                //             icon: Icon(
                //               Icons.download,
                //               color: Colors.white,
                //               size: 30,
                //             ),
                //           ),
                //   ),
                // )
              ],
            );
          },
        ),
      ),
    );
  }
}
