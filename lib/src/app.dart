import 'package:app_name/src/controllers/wallpaper_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'page/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WallpaperController());
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Colors.pink), //<-- SEE HERE
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
