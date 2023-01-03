import 'package:nrental/api/review_api.dart';
import 'package:nrental/model/review.dart';
import 'package:nrental/response/review_response.dart';

class ReviewRepository {
  Future<bool> addReview(Review review, vehicleId) async {
    return ReviewApi().addReview(review, vehicleId);
  }

  Future<ReviewResponse?> getReview(vehicleId) async {
    return ReviewApi().getReview(vehicleId);
  }
}
