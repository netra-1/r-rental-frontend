import 'package:nrental/api/booking_api.dart';
import 'package:nrental/model/bidding.dart';
import 'package:nrental/model/booking.dart';
import 'package:nrental/response/bidding_vehicle_response.dart';
import 'package:nrental/response/booking_details_response.dart';

import '../response/booking_vehicle_response.dart';

class BookingRepository {
  Future<bool> addBooking(Booking booking, vehicleId) async {
    return BookingAPI().addBooking(booking, vehicleId);
  }

  Future<bool> addBidding(Bidding booking, vehicleId) async {
    return BookingAPI().addBidding(booking, vehicleId);
  }

  Future<BookingVehicleResponse?> getBooking() async {
    return BookingAPI().getBooking();
  }

  Future<BiddingVehicleResponse?> getBidding() async {
    return BookingAPI().getBidding();
  }

  Future<BiddingVehicleResponse?> getMyBidding() async {
    return BookingAPI().getMyBidding();
  }

  Future<BookingDetailsResponse?> getBookingDetails(bookingId) async {
    return BookingAPI().getBookingDetails(bookingId);
  }

  Future<bool> deleteBooking(bookingId) async {
    return await BookingAPI().deleteBooking(bookingId);
  }

  Future<bool> updateBooking(Booking booking, bookingId) async {
    return await BookingAPI().updateBooking(booking, bookingId);
  }

  Future<bool> updateBidding(
      String price, String status, String bookingId) async {
    return await BookingAPI().updateBidding(price, status, bookingId);
  }
}
