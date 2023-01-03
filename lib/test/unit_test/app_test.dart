import 'package:flutter_test/flutter_test.dart';
import 'package:nrental/model/booking.dart';
import 'package:nrental/model/review.dart';
import 'package:nrental/model/user.dart';
import 'package:nrental/repository/article_respository.dart';
import 'package:nrental/repository/booking_repository.dart';
import 'package:nrental/repository/favourite_repository.dart';
import 'package:nrental/repository/review_repository.dart';
import 'package:nrental/repository/user_repository.dart';
import 'package:nrental/repository/vehicle_repository.dart';
import 'package:nrental/response/article_response.dart';
import 'package:nrental/response/booking_vehicle_response.dart';
import 'package:nrental/response/favourite_response.dart';
import 'package:nrental/response/review_response.dart';
import 'package:nrental/response/user_response.dart';
import 'package:nrental/response/vehicle_response.dart';

void main() {
  late UserRepository? userRepository;
  late VehicleRepository? vehicleRepository;
  late ArticleRepository? articleRepository;
  late FavouriteRepository? favouriteRepository;
  late ReviewRepository? reviewRepository;
  late BookingRepository? bookingRepository;

  setUp(() {
    userRepository = UserRepository();
    vehicleRepository = VehicleRepository();
    articleRepository = ArticleRepository();
    favouriteRepository = FavouriteRepository();
    reviewRepository = ReviewRepository();
    bookingRepository = BookingRepository();
  });

  group("Register Login", () {
    test("user registration", () async {
      bool expectedResult = true;
      User user = User(
        email: "prk.karki@gmail.com",
        username: "admin112",
        password: "admin112",
        phone: "234234324",
      );
      bool actualResult = await userRepository!.registerUser(user);
      expect(expectedResult, actualResult);
    });
    test("user login", () async {
      bool expected = true;
      String username = "admin112";
      String password = "admin112";
      bool actualResult = await userRepository!.loginUser(username, password);
      expect(expected, actualResult);
    });

    test("Get User Profile", () async {
      bool expectedResult = true;
      bool actualResult = false;
      UserResponse? userRes = await userRepository!.getUserData();
      if (userRes != null) actualResult = userRes.success!;
      expect(expectedResult, actualResult);
    });
    test("Update User Profile", () async {
      bool expectedResult = true;
      bool actualResult = false;
      User user = User(
        firstname: "Prasanna",
        lastname: "Karki",
        address: "Kaushaltar",
        gender: "Male",
        email: "prk.karki@gmail.com",
        username: "admin11",
        phone: "234234324",
      );
      actualResult = await userRepository!.updateProfile(user);
      expect(expectedResult, actualResult);
    });
  });

  group('Vehicle API test', () {
    test("Get Vehicles", () async {
      bool expectedResult = true;
      bool actualResult = false;
      VehicleResponse? vehicleRes = await vehicleRepository!.getVehicles();
      if (vehicleRes != null) actualResult = vehicleRes.success!;
      expect(expectedResult, actualResult);
    });
    test("Get Featured Vehicles ", () async {
      bool expectedResult = true;
      bool actualResult = false;
      VehicleResponse? featuredVehicleRes =
          await vehicleRepository!.getFeaturedVehicles();
      if (featuredVehicleRes != null) {
        actualResult = featuredVehicleRes.success!;
      }
      expect(expectedResult, actualResult);
    });
  });

  group('Booking API test', () {
    test("Add Booking", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String vehicleId = "62bd57a6bdc155ba1c6f70c4";
      Booking booking = Booking(
        booking_date: "2022-10-02",
        booking_time: "7:20",
        address: "Kaushaltar",
        contact_no: "213123",
        no_of_days: "3",
      );
      actualResult = await bookingRepository!.addBooking(booking, vehicleId);
      expect(expectedResult, actualResult);
    });
    test("Update Booking", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String bookingId = "62d9013b3aa33c20fe5aebf43";
      Booking booking = Booking(
        booking_date: "2022-10-02",
        booking_time: "7:20",
        address: "Bhaktapur",
        contact_no: "213123",
        no_of_days: "3",
      );
      actualResult = await bookingRepository!.updateBooking(booking, bookingId);
      expect(expectedResult, actualResult);
    });
    test("Get Bookings", () async {
      bool expectedResult = true;
      bool actualResult = false;
      BookingVehicleResponse? bookingRes =
          await bookingRepository!.getBooking();
      if (bookingRes != null) {
        actualResult = bookingRes.success!;
      }
      expect(expectedResult, actualResult);
    });
    test("Delete Booking", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String bookingId = "62d9013b3aa33c20fe5aebf9";
      actualResult = await bookingRepository!.deleteBooking(bookingId);
      expect(expectedResult, actualResult);
    });
  });

  group('Article API test', () {
    test("Get Articles", () async {
      bool expectedResult = true;
      bool actualResult = false;
      ArticleResponse? artticleRes = await articleRepository!.getArticles();
      if (artticleRes != null) actualResult = artticleRes.success!;
      expect(expectedResult, actualResult);
    });
    test("Get Featured Articles", () async {
      bool expectedResult = true;
      bool actualResult = false;
      ArticleResponse? artticleRes =
          await articleRepository!.getFeaturedArticles();
      if (artticleRes != null) actualResult = artticleRes.success!;
      expect(expectedResult, actualResult);
    });
  });

  group('Favourite API test', () {
    test("Add Favourite", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String vehicleId = "62bd57a6bdc155ba1c6f70c4";
      actualResult = await favouriteRepository!.addFavourite(vehicleId);
      expect(expectedResult, actualResult);
    });
    test("Get Favourites", () async {
      bool expectedResult = true;
      bool actualResult = false;
      FavouriteResponse? favouriteRes =
          await favouriteRepository!.getFavourite();
      if (favouriteRes != null) actualResult = favouriteRes.success!;
      expect(expectedResult, actualResult);
    });
    test("Delete Favourite", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String favouriteId = "62d8fa413aa33c20fe5aebe2";
      actualResult = await favouriteRepository!.deleteFavourite(favouriteId);
      expect(expectedResult, actualResult);
    });
  });

  group('Review API test', () {
    test("Add Review", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String vehicleId = "`62bd57a6bdc155ba1c6f70c43";
      Review review = Review(
          rating: "4",
          review: "It was easy to drive and there was no any problems.");
      actualResult = await reviewRepository!.addReview(review, vehicleId);
      expect(expectedResult, actualResult);
    });
    test("Get Reviews", () async {
      bool expectedResult = true;
      bool actualResult = false;
      String vehicleId = "62bd57a6bdc155ba1c6f70c4";
      ReviewResponse? reviewRes = await reviewRepository!.getReview(vehicleId);
      if (reviewRes != null) actualResult = reviewRes.success!;
      expect(expectedResult, actualResult);
    });
  });

  tearDown(() {
    userRepository = null;
    vehicleRepository = null;
    articleRepository = null;
    reviewRepository = null;
    bookingRepository = null;
  });
}
