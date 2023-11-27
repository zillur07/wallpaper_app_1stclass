import 'dart:typed_data';
import 'package:app_name/src/model/wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class SinglePage extends StatelessWidget {
  final WallpaperModel wallpaper;

  SinglePage({required this.wallpaper});

  Future<void> _downloadImage() async {
    try {
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
              '${wallpaper.image}', // Update to include the 'assets/' prefix
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
                onPressed: () => _downloadImage(),
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
