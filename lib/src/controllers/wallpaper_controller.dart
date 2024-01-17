import 'package:app_name/src/model/wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WallpaperController extends GetxController {
  static const String _apikey =
      'DmyYI6hXHkLfKWJ4lQHWBxvwgk247SKWi8Sf5Gi64i2Mdo1skM93heYa';

  static const String _baseUrl = "https://api.pexels.com/v1";

  final RxList<Photo> wallpapers = <Photo>[].obs;
  final RxList<Photo> wallpapersSearchList = <Photo>[].obs;
  //final RxList<CategoryModel> categoryModelList = <CategoryModel>[].obs;

  // Variable to store the current search query
  String currentSearchQuery = '';

  @override
  void onInit() {
    fetchWallpapers();
    //fetchWallpapersForCategories1();
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
}
