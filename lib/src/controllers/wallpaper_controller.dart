import 'package:app_name/src/model/wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class WallpaperController extends GetxController {
  static const String _apiKey =
      "DmyYI6hXHkLfKWJ4lQHWBxvwgk247SKWi8Sf5Gi64i2Mdo1skM93heYa";
  static const String _baseUrl = "https://api.pexels.com/v1";

  final RxList<Photo> wallpapers = <Photo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWallpapers();
  }

  void fetchWallpapers() async {
    try {
      final response = await Dio().get("$_baseUrl/curated?per_page=100",
          options: Options(
            headers: {"Authorization": _apiKey},
          ));
      final data = PexelsResponse.fromJson(response.data);
      wallpapers.assignAll(data.photos);
    } catch (error) {
      print("Error fetching wallpapers: $error");
    }
  }
}
