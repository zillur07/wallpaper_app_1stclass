import 'dart:math';
import 'package:app_name/src/model/catagory.dart';
import 'package:app_name/src/model/wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WallpaperController extends GetxController {
  static const String _apikey =
      'DmyYI6hXHkLfKWJ4lQHWBxvwgk247SKWi8Sf5Gi64i2Mdo1skM93heYa';

  static const String _baseUrl = "https://api.pexels.com/v1";

  final RxList<Photo> wallpapers = <Photo>[].obs;
  final RxList<Photo> wallpapersPopular = <Photo>[].obs;
  final RxList<Photo> wallpapersSearchList = <Photo>[].obs;
  final RxList<CategoryModel> categoryModelList = <CategoryModel>[].obs;

  //final RxList<CategoryModel> categoryModelList = <CategoryModel>[].obs;

  // Variable to store the current search query
  String currentSearchQuery = '';

  @override
  void onInit() {
    fetchWallpapers();
    fetchWallpapersForCategories1();
    fetchWallpapersPopuler();
    fetchWallpapersSearch();
    super.onInit();
  }

  ///................Home Wallpaper api,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  void fetchWallpapers() async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    try {
      final response = await Dio().get(
        '$_baseUrl/curated?&per_page=100&page=$randomNumber',
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

  ///................Home Wallpaper api,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  void fetchWallpapersPopuler() async {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    try {
      final response = await Dio().get(
        '$_baseUrl/curated?&per_page=100&page=$randomNumber',
        options: Options(
          headers: {"Authorization": _apikey},
        ),
      );
      final data = PexelsResponse.fromJson(response.data);
      wallpapersPopular.assignAll(data.photos);

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

  //..................End.........................

  ///......Srch Api work ..........................
  void fetchWallpapersSearch() async {
    Random random = Random();
    int randomNumber = random.nextInt(10);
    try {
      // Use the stored search query from the controller
      final response = await Dio().get(
        '$_baseUrl/search?query=${currentSearchQuery}&per_page=50&page=$randomNumber',
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
//.............End.....................................

  /// ..............For srch Catagory start ................

  Future<List<Photo>> fetchWallpapersSearch1(String query) async {
    const maxRetries = 3;
    int retryDelaySeconds = 2;

    for (int retryCount = 0; retryCount < maxRetries; retryCount++) {
      Random random = Random();
      int randomNumber = random.nextInt(10);
      try {
        final response = await Dio().get(
          '$_baseUrl/search?query=$query&per_page=50&page=$randomNumber',
          options: Options(
            headers: {"Authorization": _apikey},
          ),
        );

        final data = PexelsResponse.fromJson(response.data);
        wallpapersSearchList.clear();
        wallpapersSearchList.assignAll(data.photos);

        return data.photos;
      } catch (e) {
        print("Error fetching wallpapers for category: $e");

        if (e is DioError && e.response?.statusCode == 429) {
          print(
              'Received 429 status code. Retrying after $retryDelaySeconds seconds.');
          await Future.delayed(Duration(seconds: retryDelaySeconds));
          retryDelaySeconds *= 2; // Exponential backoff
        } else {
          return [];
        }
      }
    }

    print(
        'Exceeded maximum retries for fetching wallpapers for category $query.');
    return [];
  }

//............predefind catagorys,,,,,,,,,,,,,,,,,,,,,,,,,,

  void fetchWallpapersForCategories1() async {
    List<String> categoryNameList = [
      "Cars",
      "Flowers",
      'Birds',
      'Fish',
      "Nature",
      "Travel",
      'Girl',
      'Love',
      "Bikes",
      "City",
      "Abstract",
      "Minimalist",
      "Technology",
      "Space",
      "Animals",
      "Gaming",
      "Vintage",
      "Sports",
      "Street",
      "Laptop",
      'Coding',
      'Dark',
      'Computer',
      'Phone'
    ];

    categoryModelList.clear();

    for (String categoryName in categoryNameList) {
      List<Photo> photos = await fetchWallpapersSearch1(categoryName);

      if (photos.isNotEmpty) {
        //...Random image show catagory page ....................
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

  ///................End...........................................
}
