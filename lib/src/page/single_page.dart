import 'package:app_name/src/model/wallpaper.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loop_page_view/loop_page_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Images',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: LoopPageView.builder(
        itemCount: wallpaperData.length,
        onPageChanged: (index) {},
        controller: LoopPageController(initialPage: initialPageIndex),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                child: Image.network(
                  wallpaperData[index].src.medium,
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
