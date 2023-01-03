import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:mime/mime.dart';
import 'package:nrental/api/http_services.dart';
import 'package:nrental/model/vehicle.dart';
import 'package:nrental/response/login_response.dart';
import 'package:nrental/response/user_response.dart';
import 'package:nrental/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../model/user.dart';

class UserApi {
  Future<bool> registerUser(User user) async {
    bool isRegister = false;
    Response response;
    var url = baseUrl + registerUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );

      if (response.statusCode == 201) {
        return isRegister = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isRegister;
  }

  Future<bool> registerVehicle(Vehicle vehicle, File? image) async {
    bool isRegister = false;
    Response response;
    var url = baseUrl + addVehicleUrl;
    var dio = HttpServices().getDioInstance();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString("token");
    String? token = prefs.getString("token");
    try {
      FormData formData = FormData.fromMap({
        "vehicle_name": vehicle.vehicle_name,
        "vehicle_category": vehicle.vehicle_category,
        "vehicle_company": vehicle.vehicle_company,
        "vehicle_desc": vehicle.vehicle_desc,
        "vehicle_rich_desc": vehicle.vehicle_rich_desc,
        "is_featured": vehicle.is_featured,
        "booking_cost": vehicle.booking_cost,
        "vehicle_sku": vehicle.vehicle_sku,
        "v_img": await MultipartFile.fromFile(
          image!.path,
          filename: image.path.split("/").last,
          contentType: MediaType(
            "image",
            "jpeg",
          ),
        ),
      });
      response = await dio.post(url,
          data: formData,
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $token",
            },
          ));

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        return isRegister = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isRegister;
  }

  Future<bool> loginUser(String username, String password) async {
    bool isLogin = false;
    String? token;
    Response response;
    var url = baseUrl + loginUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio
          .post(url, data: {"username": username, "password": password});
      print(response);
      if (response.statusCode == 201) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        token = loginResponse.token;
        _setDataToSharedPref(token!);
        if (token == '') {
          isLogin = false;
        } else {
          isLogin = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isLogin;
  }

  Future<UserResponse?> getUserData() async {
    Future.delayed(const Duration(seconds: 2), () {});
    UserResponse? userResponse;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(getUserUrl,
          options: buildCacheOptions(const Duration(days: 7),
              forceRefresh: true,
              options: Options(
                headers: {
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
              )));
      if (response.statusCode == 201) {
        userResponse = UserResponse.fromJson(response.data);
      } else {
        userResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }

    return userResponse;
  }

  Future<bool> updateProfile(User user) async {
    bool isUpdated = false;
    Response response;
    var dio = HttpServices().getDioInstance();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      response = await dio.put(updateProfileUrl,
          data: user.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          }));

      if (response.statusCode == 201) {
        return isUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUpdated;
  }

  Future<bool> updatePassword(Map<String, dynamic> password) async {
    bool isUpdated = false;
    Response response;
    var dio = HttpServices().getDioInstance();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");

      response = await dio.put(updatePasswordUrl,
          data: jsonEncode(password),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          }));

      if (response.statusCode == 201) {
        return isUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUpdated;
  }

  Future<bool> updateProfileImage(File? file) async {
    bool isUpdated = false;
    Response response;
    var dio = HttpServices().getDioInstance();
    MultipartFile? image;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }
      var formData = FormData.fromMap({
        "user_img": image,
      });
      response = await dio.put(updateImageUrl,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          }));

      if (response.statusCode == 201) {
        return isUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return isUpdated;
  }
}

_setDataToSharedPref(String token) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  } catch (e) {
    debugPrint(e.toString());
  }
}
