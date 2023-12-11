import 'package:app_name/src/controllers/wallpaper_controller.dart';
import 'package:app_name/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WallpaperController());
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}
