import 'package:app_name/src/model/wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:loop_page_view/loop_page_view.dart';

class SinglePage extends StatelessWidget {
  final List<WallpaperModel> wallpaperData;
  final int initialPageIndex;

  SinglePage({required this.wallpaperData, required this.initialPageIndex});

  Future<void> _downloadImage(int pageIndex) async {
    try {
      WallpaperModel wallpaper = wallpaperData[pageIndex];

      // Load image bytes from asset bundle
      ByteData data = await rootBundle.load('${wallpaper.image}');
      Uint8List bytes = data.buffer.asUint8List();

      // Save image to gallery
      var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80, // You can specify the image quality (0 to 100)
      );

      if (result['isSuccess']) {
        // Image saved successfully
        print('Image saved to gallery');

        Get.snackbar(
          'Save Wallpaper',
          'Image Save your Gallery',
          backgroundColor: Colors.teal.withOpacity(.5),
        );
      } else {
        // Image save failed
        print('Failed to save image: ${result['error']}');
      }
    } catch (error) {
      // Handle the error
      print('Error saving image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          wallpaperData[initialPageIndex].name.toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: LoopPageView.builder(
        itemCount: wallpaperData.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                child: Image.asset(
                  '${wallpaperData[index].image}',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15,
                left: 140,
                right: 140,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red.withOpacity(.5),
                  ),
                  child: IconButton(
                    onPressed: () => _downloadImage(index),
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
        onPageChanged: (index) {
          // Handle page change if needed
        },
        controller: LoopPageController(initialPage: initialPageIndex),
      ),
    );
  }
}
