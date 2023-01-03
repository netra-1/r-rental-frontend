import 'package:nrental/api/favourite_api.dart';
import 'package:nrental/response/favourite_response.dart';

class FavouriteRepository {
  Future<bool> addFavourite( vehicleId) async {
    return FavouriteApi().addFavourite(vehicleId);
  }

  Future<FavouriteResponse?> getFavourite() async {
    return FavouriteApi().getFavourite();
  }

  Future<bool> deleteFavourite(favouriteId) async {
    return await FavouriteApi().deleteFavourite(favouriteId);
  }

  
}
