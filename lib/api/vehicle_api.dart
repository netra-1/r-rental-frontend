import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:nrental/api/http_services.dart';
import 'package:nrental/response/vehicle_response.dart';
import 'package:nrental/utils/url.dart';

class VehicleAPI {
  Future<VehicleResponse?> getVehicles() async {
    Future.delayed(const Duration(seconds: 2), () {});
    VehicleResponse? vehicleResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(vehicleUrl,
          options: buildCacheOptions(const Duration(days: 7)));
      if (response.statusCode == 201) {
        vehicleResponse = VehicleResponse.fromJson(response.data);
      } else {
        vehicleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return vehicleResponse;
  }

  Future<VehicleResponse?> getFeaturedVehicles() async {
    Future.delayed(const Duration(seconds: 2), () {});
    VehicleResponse? vehicleResponse;
    try {
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(featuredVehicleUrl,
          options: buildCacheOptions(const Duration(days: 7)));
      debugPrint(response.toString());
      if (response.statusCode == 201) {
        vehicleResponse = VehicleResponse.fromJson(response.data);
      } else {
        vehicleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return vehicleResponse;
  }
}
