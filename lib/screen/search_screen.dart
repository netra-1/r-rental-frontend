import 'package:flutter/material.dart';
import 'package:nrental/model/vehicle.dart';
import 'package:nrental/repository/vehicle_repository.dart';
import 'package:nrental/response/vehicle_response.dart';
import 'package:nrental/utils/url.dart';

import '../components/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String category = '';
  String searchQuery = '';
  Color bgColorCar = const Color.fromRGBO(243, 243, 243, 1);
  Color bgColorBike = const Color.fromRGBO(243, 243, 243, 1);
  Color bgColorBus = const Color.fromRGBO(243, 243, 243, 1);
  Color bgColorVan = const Color.fromRGBO(243, 243, 243, 1);
  String carIcon = "car-red.png";
  String bikeIcon = "bike-red.png";
  String busIcon = "bus-red.png";
  String vanIcon = "van-red.png";
  final _searchQueryController = TextEditingController();

  _iconClicked(String vehicle) {
    if (vehicle == "Car") {
      carIcon = "car-white.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-red.png";
      vanIcon = "van-red.png";
      bgColorCar = Color.fromARGB(255, 94, 196, 255);
      bgColorBike =
          bgColorVan = bgColorBus = const Color.fromRGBO(243, 243, 243, 1);
    }
    if (vehicle == "Bike") {
      carIcon = "car-red.png";
      bikeIcon = "bike-white.png";
      busIcon = "bus-red.png";
      vanIcon = "van-red.png";
      bgColorBike = Color.fromARGB(255, 94, 196, 255);
      bgColorCar =
          bgColorVan = bgColorBus = const Color.fromRGBO(243, 243, 243, 1);
    }
    if (vehicle == "Van") {
      carIcon = "car-red.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-red.png";
      vanIcon = "van-white.png";
      bgColorVan = Color.fromARGB(255, 94, 196, 255);
      bgColorCar =
          bgColorBike = bgColorBus = const Color.fromRGBO(243, 243, 243, 1);
    }
    if (vehicle == "Bus") {
      carIcon = "car-red.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-white.png";
      vanIcon = "van-red.png";
      bgColorBus = Color.fromARGB(255, 94, 196, 255);
      bgColorCar =
          bgColorVan = bgColorBike = const Color.fromRGBO(243, 243, 243, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // searchBox(),
            // const CategoryWidget(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: TextFormField(
                    controller: _searchQueryController,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      border: InputBorder.none,
                      hintText: "Search rooms",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey),
                      suffixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              searchQuery = _searchQueryController.text;
                              print(searchQuery);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                vehicleCategory(bgColorCar, carIcon, "Car"),
                vehicleCategory(bgColorBike, bikeIcon, "Bike"),
                vehicleCategory(bgColorVan, vanIcon, "Van"),
                vehicleCategory(bgColorBus, busIcon, "Bus")
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 100,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      category = "";
                      searchQuery = "";
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'View All',
                        style: TextStyle(fontSize: 14),
                      ),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder<VehicleResponse?>(
              future: VehicleRepository().getVehicles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Vehicle> lstVehiclesAll = snapshot.data!.data!;
                    List<Vehicle> lstVehicles;
                    if (searchQuery != "") {
                      List<Vehicle> lstVehiclesFiltered = lstVehiclesAll
                          .where((v) => v.vehicle_name!
                              .toLowerCase()
                              .contains(searchQuery))
                          .toList();
                      lstVehicles = lstVehiclesFiltered;
                    } else if (category != "") {
                      List<Vehicle> lstVehiclesFiltered = lstVehiclesAll
                          .where((v) => v.vehicle_category == category)
                          .toList();
                      lstVehicles = lstVehiclesFiltered;
                    } else {
                      lstVehicles = lstVehiclesAll;
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        mainAxisExtent: 260,
                        crossAxisSpacing: 20,
                      ),
                      padding: const EdgeInsets.all(8),
                      itemCount: lstVehicles.length,
                      itemBuilder: (context, index) {
                        final vehicle = lstVehicles[index];
                        return vehicleCard(vehicle);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No Data"),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget vehicleCategory(bgColor, icon, vehicleType) {
    return InkWell(
      key: ValueKey('categoryBtn $vehicleType'),
      onTap: () => setState(() {
        category = vehicleType;
        searchQuery = "";
        // _iconClicked(vehicleType);
        print(category);
      }),
      child: AnimatedContainer(
        height: 70,
        width: 80,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: Center(
          child: Image.asset("assets/images/$icon"),
        ),
      ),
    );
  }

  Widget vehicleCard(vehicle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // const Align(
            //   alignment: Alignment.topRight,
            //   child: Icon(
            //     Icons.bookmark,
            //     color: Colors.grey,
            //   ),
            // ),
            // Image.network(
            //   "https://nepalvehiclebooking.com/wp-content/uploads/2020/02/SONATA-hero-option1-764A5360-edit-640x354.jpg",
            //   height: 90,
            //   fit: BoxFit.contain,
            // ),
            Image.network(
              '$baseUrl${vehicle.vehicle_image}',
              height: 100,
              fit: BoxFit.contain,
            ),
            //  baseUrl.contains('10.0.2.2')
            //               ? CircleAvatar(
            //                   backgroundImage: NetworkImage(
            //                     lstProductCategory[index]
            //                         .image!
            //                         .replaceAll('localhost', '10.0.2.2'),
            //                   ),
            //                 )
            //               : CircleAvatar(
            //                   backgroundImage: NetworkImage(
            //                       lstProductCategory[index].image!),
            //                 ),
            const SizedBox(
              height: 20,
            ),
            Text(
              vehicle.vehicle_name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Rs ${vehicle.booking_cost}/day",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              key: ValueKey('bookBtn ${vehicle.vehicle_name}'),
              width: 80,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 94, 196, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () => {
                  Navigator.pushNamed(context, '/vehicleScreen',
                      arguments: vehicle)
                },
                child: const Text(
                  "Book",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBox() => SearchWidget(
        text: category,
        hintText: 'Search  Vehicles',
        onChanged: searchVehicle,
      );
  void searchVehicle(String query) {
    // final vehicles = lstVehicles.where((vehicle) {
    //   final vehicleName = vehicle.vehicle_name?.toLowerCase();
    //   final searchText = query.toLowerCase();
    //   return vehicleName!.contains(searchText);
    // }).toList();

    // setState(() {
    //   this.query = query;
    //   allVehicles = vehicles;
    // });
  }
}
