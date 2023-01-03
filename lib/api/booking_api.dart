import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:nrental/api/http_services.dart';
import 'package:nrental/model/bidding.dart';
import 'package:nrental/model/booking.dart';
import 'package:nrental/response/bidding_vehicle_response.dart';
import 'package:nrental/response/booking_details_response.dart';
import 'package:nrental/response/booking_vehicle_response.dart';
import 'package:nrental/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingAPI {
  Future<bool> addBooking(Booking booking, vehicleId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      var response = await dio.post(bookingUrl + vehicleId,
          data: booking.toJson(),
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

  Future<bool> addBidding(Bidding booking, vehicleId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      debugPrint(booking.price.toString());
      var response = await dio.post(biddingUrl + vehicleId,
          data: booking.toJson(),
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

  Future<bool> updateBooking(Booking booking, bookingId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      var response = await dio.put(updateBookingUrl + bookingId,
          data: booking.toJson(),
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

  Future<bool> updateBidding(
      String price, String status, String bookingId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      var response = await dio.put(updateBiddingUrl + bookingId,
          data: {
            "price": price,
            "status": status,
          },
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

  Future<bool> deleteBooking(bookingId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      var response = await dio.delete(deleteBookingUrl + bookingId,
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

  Future<BookingVehicleResponse?> getBooking() async {
    Future.delayed(const Duration(seconds: 2), () {});
    BookingVehicleResponse? bookingVehicleResponse;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(getBookingUrl,
          options: buildCacheOptions(const Duration(days: 7),
              forceRefresh: true,
              options: Options(
                headers: {
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
              )));
      if (response.statusCode == 201) {
        bookingVehicleResponse = BookingVehicleResponse.fromJson(response.data);
      } else {
        bookingVehicleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return bookingVehicleResponse;
  }

  Future<BiddingVehicleResponse?> getBidding() async {
    Future.delayed(const Duration(seconds: 2), () {});
    BiddingVehicleResponse? biddingVehicleResponse;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(getBiddingUrl,
          options: buildCacheOptions(const Duration(days: 7),
              forceRefresh: true,
              options: Options(
                headers: {
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
              )));
      if (response.statusCode == 201) {
        biddingVehicleResponse = BiddingVehicleResponse.fromJson(response.data);
      } else {
        biddingVehicleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return biddingVehicleResponse;
  }

  Future<BiddingVehicleResponse?> getMyBidding() async {
    Future.delayed(const Duration(seconds: 2), () {});
    BiddingVehicleResponse? biddingVehicleResponse;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(getMyBiddingUrl,
          options: buildCacheOptions(const Duration(days: 7),
              forceRefresh: true,
              options: Options(
                headers: {
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
              )));
      if (response.statusCode == 201) {
        biddingVehicleResponse = BiddingVehicleResponse.fromJson(response.data);
      } else {
        biddingVehicleResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return biddingVehicleResponse;
  }

  Future<BookingDetailsResponse?> getBookingDetails(bookingId) async {
    Future.delayed(const Duration(seconds: 2), () {});
    BookingDetailsResponse? bookingDetailsResponse;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.getString("token");
      String? token = prefs.getString("token");
      var dio = HttpServices().getDioInstance();
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
      Response response = await dio.get(getBookingDetailsUrl + bookingId,
          options: buildCacheOptions(const Duration(days: 7),
              forceRefresh: true,
              options: Options(
                headers: {
                  HttpHeaders.authorizationHeader: "Bearer $token",
                },
              )));
      if (response.statusCode == 201) {
        bookingDetailsResponse = BookingDetailsResponse.fromJson(response.data);
      } else {
        bookingDetailsResponse = null;
      }
    } catch (e) {
      throw Exception(e);
    }
    return bookingDetailsResponse;
  }
}
