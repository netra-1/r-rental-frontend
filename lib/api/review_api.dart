import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:nrental/api/http_services.dart';
import 'package:nrental/response/review_response.dart';
import 'package:nrental/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/review.dart';

class ReviewApi {
  Future<bool> addReview(Review review, vehicleId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      var response = await dio.post(addReviewUrl + vehicleId,
          data: review.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          }));
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }
    return false;
  }

  Future<ReviewResponse?> getReview(vehicleId) async {
    Future.delayed(const Duration(seconds: 2), () {});
    ReviewResponse? reviewResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(
        getReviewUrl + vehicleId,
        options: buildCacheOptions(
          const Duration(days: 7),
          forceRefresh: true,
        ),
      );
      if (response.statusCode == 201) {
        reviewResponse = ReviewResponse.fromJson(response.data);
      } else {
        reviewResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return reviewResponse;
  }
}
