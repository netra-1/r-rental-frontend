import 'package:flutter/material.dart';
import 'package:nrental/model/vehicle.dart';
import 'package:nrental/repository/vehicle_repository.dart';
import 'package:nrental/response/vehicle_response.dart';
import 'package:nrental/utils/url.dart';

class WearOSVehicleScreen extends StatefulWidget {
  const WearOSVehicleScreen({Key? key}) : super(key: key);

  @override
  State<WearOSVehicleScreen> createState() => _WearOSVehicleScreenState();
}

class _WearOSVehicleScreenState extends State<WearOSVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicles",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<VehicleResponse?>(
                future: VehicleRepository().getVehicles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Vehicle> lstVehicles = snapshot.data!.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final vehicle = lstVehicles[index];
                            return Padding(
                                padding: const EdgeInsets.all(10),
                                child: vehicleCard(vehicle));
                          });
                    } else {
                      return const Text("No data");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget vehicleCard(vehicle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Image.network(
              '$baseUrl${vehicle.vehicle_image}',
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              vehicle.vehicle_name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rs ${vehicle.booking_cost}/day",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 100,
              height: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 94, 196, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () => {
                  Navigator.pushNamed(context, '/wearosVehicleDetailScreen',
                      arguments: vehicle)
                },
                child: const Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
