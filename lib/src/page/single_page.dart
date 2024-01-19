import 'package:app_name/src/model/wallpaper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:loop_page_view/loop_page_view.dart';

enum WallpaperType {
  SetWallpaper,
  SetLockWallpaper,
  SetBoth,
}

class SinglePage extends StatefulWidget {
  final List<Photo> wallpaperData;
  final int initialPageIndex;

  SinglePage({required this.wallpaperData, required this.initialPageIndex});

  @override
  _SinglePageState createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  int currentPageIndex = 0;
  bool _settingWallpaper = false;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPageIndex;
  }

  Future<void> _downloadImage(int photoIndex) async {
    try {
      Photo wallpaper = widget.wallpaperData[photoIndex];

      dio.Response<List<int>> response = await dio.Dio().get<List<int>>(
        wallpaper.src.large2x,
        options: dio.Options(responseType: dio.ResponseType.bytes),
      );

      Uint8List bytes = Uint8List.fromList(response.data!);

      var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 100,
      );

      if (result['isSuccess']) {
        Get.back();
        _showSuccessSnackbar(
            'Download successfully', 'Image saved Successfully');
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

      _showSuccessSnackbar(
          'Set Wallpaper successfully', 'Wallpaper Set Successfully');
    }
  }

  void _showSuccessSnackbar(String? title, String message) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.pink,
        snackPosition: SnackPosition.TOP,
        title: title,
        message: message,
        icon: Icon(
          Icons.image_rounded,
          color: Colors.white,
          size: 35,
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Wallpaper',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.pink),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () => _showBottomSheet(),
          icon: Icon(
            Icons.file_download_outlined,
            size: 26,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildCircularProgressIndicator() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
    );
  }

  Widget _buildBottomSheetContent(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 90,
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(5)),
          ),
          SizedBox(
            height: 15,
          ),
          const Text(
            'What would you like to do?',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => setWallpaper(WallpaperType.SetWallpaper, index),
            child: _buildActionContainer(
              Icons.image_outlined,
              'SET WALLPAPER',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => setWallpaper(WallpaperType.SetLockWallpaper, index),
            child: _buildActionContainer(
              Icons.lock_outline_rounded,
              'SET LOCK SCREEN',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => setWallpaper(WallpaperType.SetBoth, index),
            child: _buildActionContainer(
              Icons.photo_size_select_actual_outlined,
              'SET BOTH SCREEN',
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => _downloadImage(index),
            child: _buildActionContainer(
              Icons.file_download_outlined,
              'SAVE TO MEDIA FOLDER',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildActionContainer(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.pink),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    Get.bottomSheet(
      Container(
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: _settingWallpaper
            ? _buildCircularProgressIndicator()
            : _buildBottomSheetContent(currentPageIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => LoopPageView.builder(
          itemCount: widget.wallpaperData.length,
          onPageChanged: onPageChanged,
          controller: LoopPageController(initialPage: widget.initialPageIndex),
          itemBuilder: _buildPageItem,
        ),
      ),
    );
  }

  Widget _buildPageItem(BuildContext context, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => _showBottomSheet(),
          child: Hero(
            tag: 'heroTag_$index', // Use the same tag
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              // child: Image.network(
              //   widget.wallpaperData[index].src.large2x,
              //   fit: BoxFit.cover,
              // ),

              child: CachedNetworkImage(
                imageUrl: widget.wallpaperData[index].src.portrait,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                    value: progress.progress,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
