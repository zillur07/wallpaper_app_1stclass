import 'dart:math';
import 'package:app_name/src/model/catagory.dart';
import 'package:app_name/src/model/wallpaper.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class WallpaperController extends GetxController {
  static const String _apikey =
      'DmyYI6hXHkLfKWJ4lQHWBxvwgk247SKWi8Sf5Gi64i2Mdo1skM93heYa';

  static const String _baseUrl = "https://api.pexels.com/v1";

  final RxList<Photo> wallpapers = <Photo>[].obs;
  final RxList<Photo> wallpapersSearchList = <Photo>[].obs;
  final RxList<CategoryModel> categoryModelList = <CategoryModel>[].obs;

  // Variable to store the current search query
  String currentSearchQuery = '';

  @override
  void onInit() {
    fetchWallpapers();
    fetchWallpapersForCategories1();
    fetchWallpapersSearch();
    super.onInit();
  }

  void fetchWallpapers() async {
    try {
      final response = await Dio().get(
        '$_baseUrl/curated?per_page=100',
        options: Options(
          headers: {"Authorization": _apikey},
        ),
      );
      final data = PexelsResponse.fromJson(response.data);
      wallpapers.assignAll(data.photos);

      print(data.photos);
    } catch (e) {
      print("Error fetching wallpapers: $e");
    }
  }

  // Method to update the search query
  void updateSearchQuery(String query) {
    // Update the stored search query
    currentSearchQuery = query;
  }

  void fetchWallpapersSearch() async {
    try {
      // Use the stored search query from the controller
      final response = await Dio().get(
        '$_baseUrl/search?query=${currentSearchQuery}&per_page=30&page=1',
        options: Options(
          headers: {"Authorization": _apikey},
        ),
      );
      final data = PexelsResponse.fromJson(response.data);
      wallpapersSearchList.clear();
      wallpapersSearchList.assignAll(data.photos);

      print(data.photos);
    } catch (e) {
      print("Error fetching wallpapers: $e");
    }
  }

  Future<List<Photo>> fetchWallpapersSearch1(String query) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/search?query=$query&per_page=12',
        options: Options(
          headers: {"Authorization": _apikey},
        ),
      );

      final data = PexelsResponse.fromJson(response.data);
      return data.photos;
    } catch (e) {
      print("Error fetching wallpapers for category: $e");
      return [];
    }
  }

  void fetchWallpapersForCategories1() async {
    List<String> categoryNameList = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers",
      "Laptop",
      'Coding',
      'Girl',
      'Computer'
    ];

    categoryModelList.clear();

    for (String categoryName in categoryNameList) {
      List<Photo> photos = await fetchWallpapersSearch1(categoryName);

      if (photos.isNotEmpty) {
        final _random = Random();
        int randomIndex = _random.nextInt(photos.length);
        Photo photo = photos[randomIndex];

        categoryModelList.add(CategoryModel(
          catImgUrl:
              photo.src.medium, // Use the appropriate URL from your Photo class
          catName: categoryName,
        ));
      }
    }
  }
}
