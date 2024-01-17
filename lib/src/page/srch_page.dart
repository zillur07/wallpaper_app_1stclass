import 'package:app_name/src/component/wellpaper_serach_component.dart';
import 'package:app_name/src/controllers/wallpaper_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 45.0,
                right: 8.0,
                top: 4,
                bottom: 4,
              ),
              child: GetBuilder<WallpaperController>(
                builder: (controller) => TextField(
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.white),
                  onChanged: (query) {
                    // Update the search query in the controller
                    controller.updateSearchQuery(query);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Trigger the search
                        controller.fetchWallpapersSearch();
                      },
                    ),
                    suffixIconColor: Colors.red,
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            WellpaperSearchComponent(),
          ],
        ),
      ),
    );
  }
}
