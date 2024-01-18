import 'dart:async';
import 'package:app_name/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
// Get the AuthController instance
// Get the AuthController instance

  @override
  void initState() {
    super.initState();
    // Load the main screen after a delay
    Timer(Duration(seconds: 3), () {
      Get.off(() => HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to match your splash screen background color.
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'img/sp.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
