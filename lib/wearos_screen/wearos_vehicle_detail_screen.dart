import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nrental/model/vehicle.dart';
import 'package:nrental/repository/favourite_repository.dart';
import 'package:nrental/utils/url.dart';

class WearOSVehicleDetailScreen extends StatefulWidget {
  const WearOSVehicleDetailScreen({Key? key}) : super(key: key);

  @override
  State<WearOSVehicleDetailScreen> createState() =>
      _WearOSVehicleDetailScreenState();
}

class _WearOSVehicleDetailScreenState extends State<WearOSVehicleDetailScreen> {
  _addFavourite(vehicleId) async {
    bool isAdded = await FavouriteRepository().addFavourite(vehicleId);
    if (isAdded) {
      _displayMessage("Added to favourite");
    } else {
      _displayMessage("Failed !!");
    }
  }

  _displayMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        fontSize: 10,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        textColor: const Color.fromARGB(255, 255, 255, 255));
  }

  @override
  Widget build(BuildContext context) {
    Vehicle vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 80,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '$baseUrl${vehicle.vehicle_image}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: -13,
                      child: IconButton(
                        icon: const Icon(
                          Icons.bookmark_add,
                          color: Colors.red,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _addFavourite(vehicle.id);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '${vehicle.vehicle_name}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Rs. ${vehicle.booking_cost} / day',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.green),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Specifications",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 98, 98, 98),
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${vehicle.vehicle_desc}   Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 156, 156, 156),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
