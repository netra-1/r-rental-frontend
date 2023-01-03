import 'package:nrental/api/vehicle_api.dart';
import 'package:nrental/response/vehicle_response.dart';

class VehicleRepository {
  Future<VehicleResponse?> getVehicles() async {
    return VehicleAPI().getVehicles();
  }

  Future<VehicleResponse?> getFeaturedVehicles() async {
    return VehicleAPI().getFeaturedVehicles();
  }
}
