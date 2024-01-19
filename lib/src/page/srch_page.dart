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
                left: 50.0,
                right: 15.0,
                top: 6,
                bottom: 6,
              ),
              child: GetBuilder<WallpaperController>(
                builder: (controller) => TextField(
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (query) {
                    // Update the search query in the controller
                    controller.updateSearchQuery(query);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              WellpaperSearchComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
