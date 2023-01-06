import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:nrental/repository/vehicle_repository.dart';
import 'package:nrental/response/vehicle_response.dart';
import 'package:nrental/utils/url.dart';

import '../model/vehicle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color bgColorCar = const Color.fromRGBO(243, 243, 243, 1);
  Color bgColorBike = const Color.fromRGBO(243, 243, 243, 1);
  Color bgColorBus = const Color.fromRGBO(243, 243, 243, 1);
  Color bgColorVan = const Color.fromRGBO(243, 243, 243, 1);
  String carIcon = "car-red.png";
  String bikeIcon = "bike-red.png";
  String busIcon = "bus-red.png";
  String vanIcon = "van-red.png";

  _iconClicked(String vehicle) {
    if (vehicle == "Car") {
      carIcon = "car-red.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-red.png";
      vanIcon = "van-red.png";
      bgColorCar = const Color.fromARGB(255, 255, 255, 255);
      bgColorBike =
          bgColorVan = bgColorBus = const Color.fromARGB(255, 255, 255, 255);
    }
    if (vehicle == "Bike") {
      carIcon = "car-red.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-red.png";
      vanIcon = "van-red.png";
      bgColorBike = const Color.fromARGB(255, 54, 168, 229);
      bgColorCar =
          bgColorVan = bgColorBus = const Color.fromARGB(255, 255, 255, 255);
    }
    if (vehicle == "Van") {
      carIcon = "car-red.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-red.png";
      vanIcon = "van-red.png";
      bgColorVan = const Color.fromARGB(255, 54, 168, 229);
      bgColorCar = bgColorBike = bgColorBus = Colors.white;
    }
    if (vehicle == "bus") {
      carIcon = "car-red.png";
      bikeIcon = "bike-red.png";
      busIcon = "bus-red.png";
      vanIcon = "van-red.png";
      bgColorBus = const Color.fromARGB(255, 54, 168, 229);
      bgColorCar =
          bgColorVan = bgColorBike = const Color.fromARGB(255, 255, 255, 255);
    }
  }

  // List<Vehicle> lstVehicle = [
  //   Vehicle(
  //     name: "Yamaha r1",
  //     image:
  //         "https://i.pinimg.com/originals/64/a5/92/64a5923a87f1a724a0b2f5ea1535dcab.png",
  //     cost: "9000",
  //   ),
  //   Vehicle(
  //     name: "Tesla Model S",
  //     image: "https://www.picng.com/upload/tesla_car/png_tesla_car_23349.png",
  //     cost: "9000",
  //   ),
  //   Vehicle(
  //     name: "Toyota Hiace",
  //     image:
  //         "https://www.seekpng.com/png/full/430-4304003_hiace-super-long-wheelbase-commuter-bus-french-vanilla.png",
  //     cost: "9000",
  //   ),
  //   Vehicle(
  //     name: "CBR sport",
  //     image:
  //         "https://www.freepnglogos.com/uploads/bike-png/honda-cbr-sport-bike-png-image-pngpix-22.png",
  //     cost: "9000",
  //   ),
  //   Vehicle(
  //     name: "Tour Bus",
  //     image: "https://www.freeiconspng.com/thumbs/bus-png/bus-png-4.png",
  //     cost: "9000",
  //   )
  // ];

  // List<Brand> lstBrand = [
  //   Brand(
  //       image:
  //           "https://i0.wp.com/zeevector.com/wp-content/uploads/2021/02/TVS-Logo-PNG.png?fit=1088%2C255&ssl=1"),
  //   Brand(
  //     image:
  //         "https://e7.pngegg.com/pngimages/773/525/png-clipart-yamaha-motor-company-yamaha-corporation-motorcycle-logo-pixels-kingdom-gmbh-motorcycle-text-trademark.png",
  //   ),
  //   Brand(
  //     image:
  //         "https://logos-world.net/wp-content/uploads/2021/03/Hyundai-Logo-2011-2017.png",
  //   ),
  //   Brand(
  //     image:
  //         "https://cdn.freebiesupply.com/logos/large/2x/honda-7-logo-png-transparent.png",
  //   ),
  //   Brand(
  //     image:
  //         "https://www.freepnglogos.com/uploads/toyota-logo-png/toyota-logos-brands-logotypes-0.png",
  //   ),
  // ];

  int counter = 1;
  _checkNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isaAllowed) {
        if (!isaAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  _showNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: counter,
        channelKey: 'basic_channel',
        title: "Car Booked",
        body: 'You have successfully booked a tesla',
      ),
    );
    setState(() {
      counter++;
    });
  }

  @override
  void initState() {
    _checkNotificationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 252, 255),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        "https://img.freepik.com/free-vector/house-rent-abstract-concept-vector-illustration-booking-house-online-best-rental-property-real-estate-service-accommodation-marketplace-rental-listing-monthly-rent-abstract-metaphor_335657-1954.jpg",
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Rent a house not a room",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "30% OFF",
                            style: TextStyle(
                              color: Color.fromARGB(255, 54, 168, 244),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 94, 185, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            onPressed: () => {},
                            child: const Text(
                              "Book now",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: 50,
            //     child: ListView.separated(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: lstBrand.length,
            //       separatorBuilder: (context, _) => SizedBox(
            //         width: MediaQuery.of(context).size.width * 0.2,
            //       ),
            //       itemBuilder: (context, index) => brandCard(lstBrand[index]),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Text(
                      "Explore",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                    ),
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder<VehicleResponse?>(
              future: VehicleRepository().getFeaturedVehicles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Vehicle> lstVehicles = snapshot.data!.data!;
                    debugPrint(lstVehicles.length.toString());

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        mainAxisExtent: 300,
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
            // Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: Column(
            //       children: [
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         const Divider(
            //           color: Color.fromARGB(179, 123, 120, 120),
            //         ),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Row(
            //             children: const [
            //               Icon(
            //                 Icons.my_library_books,
            //                 size: 30,
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(
            //                 "Articles",
            //                 style: TextStyle(
            //                     fontSize: 20, fontWeight: FontWeight.w900),
            //               ),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         FutureBuilder<ArticleResponse?>(
            //           future: ArticleRepository().getFeaturedArticles(),
            //           builder: (context, snapshot) {
            //             if (snapshot.connectionState == ConnectionState.done) {
            //               if (snapshot.hasData) {
            //                 List<Article> lstArticles = snapshot.data!.data!;
            //                 return ListView.builder(
            //                     shrinkWrap: true,
            //                     itemCount: snapshot.data!.data!.length,
            //                     physics: const NeverScrollableScrollPhysics(),
            //                     itemBuilder: (context, index) {
            //                       final article = lstArticles[index];
            //                       return Padding(
            //                           padding:
            //                               const EdgeInsets.only(bottom: 20.0),
            //                           child: articleCard(article));
            //                     });
            //               } else {
            //                 return const Center(
            //                   child: Text("No data"),
            //                 );
            //               }
            //             } else if (snapshot.connectionState ==
            //                 ConnectionState.waiting) {
            //               return const Center(
            //                 child: CircularProgressIndicator(),
            //               );
            //             } else if (snapshot.hasError) {
            //               return Text("${snapshot.error}");
            //             } else {
            //               return const Center(
            //                 child: CircularProgressIndicator(
            //                   valueColor:
            //                       AlwaysStoppedAnimation<Color>(Colors.blue),
            //                 ),
            //               );
            //             }
            //           },
            //         ),
            //       ],
            //     )),
          ],
        ),
      ),
    );
  }

  Widget vehicleCategory(bgColor, icon, vehicleType) {
    return InkWell(
      onTap: () => setState(() {
        _iconClicked("$vehicleType");
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
    debugPrint(vehicle.toString());
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
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/mapPage');
              },
              child: Text(
                "Location: ${vehicle.vehicle_rich_desc}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Rs ${vehicle.booking_cost}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 70,
                  key: ValueKey('bookBtn ${vehicle.vehicle_name}'),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 94, 196, 255),
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
                  width: 10,
                ),
                SizedBox(
                  width: 58,
                  // key: ValueKey('bookBtn ${vehicle.vehicle_name}'),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 94, 196, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () => {
                      Navigator.pushNamed(context, '/biddingScreen',
                          arguments: vehicle)
                    },
                    child: const Text(
                      "Bid",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }

  Widget brandCard(brand) => SizedBox(
        width: 60,
        child: Image.network(
          brand.image!,
          fit: BoxFit.contain,
        ),
      );
  Widget articleCard(article) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
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
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              '$baseUrl${article.image}',
              // height: 190,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "${article.date}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "${article.title}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Color.fromARGB(179, 126, 122, 122),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "${article.description}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 94, 196, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      child: const Text(
                        "Read more",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () => {
                        Navigator.pushNamed(context, '/articleDetailsScreen',
                            arguments: article)
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
