// import 'package:app_name/src/model/wallpaper.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';

// class WallpaperController extends GetxController {
//   static const String _apikey =
//       'DmyYI6hXHkLfKWJ4lQHWBxvwgk247SKWi8Sf5Gi64i2Mdo1skM93heYa';

//   static const String _baseUrl = "https://api.pexels.com/v1";

//   final RxList<Photo> wallpapers = <Photo>[].obs;
//   final RxList<Photo> wallpapersSearchList = <Photo>[].obs;

//   @override
//   void onInit() {
//     fetchWallpapers();
//     super.onInit();
//   }

//   void fetchWallpapers() async {
//     try {
//       final response = await Dio().get(
//         '$_baseUrl/curated?per_page=100',
//         options: Options(
//           headers: {"Authorization": _apikey},
//         ),
//       );
//       final data = PexelsResponse.fromJson(response.data);
//       wallpapers.assignAll(data.photos);

//       print(data.photos);
//     } catch (e) {
//       print("Error fetching wallpapers: $e");
//     }
//   }

//   void fetchWallpapersSerch(String query) async {
//     try {
//       final response = await Dio().get(
//         '$_baseUrl/search?query=$query&per_page=30&page=1',
//         options: Options(
//           headers: {"Authorization": _apikey},
//         ),
//       );
//       final data = PexelsResponse.fromJson(response.data);
//       wallpapersSearchList.clear();
//       wallpapersSearchList.assignAll(data.photos);

//       print(data.photos);
//     } catch (e) {
//       print("Error fetching wallpapers: $e");
//     }
//   }
// }
