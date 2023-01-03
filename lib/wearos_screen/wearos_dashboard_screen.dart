import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear/wear.dart';

class WearOSDashboardScreen extends StatefulWidget {
  const WearOSDashboardScreen({Key? key}) : super(key: key);

  @override
  State<WearOSDashboardScreen> createState() => _WearOSDashboardScreenState();
}

class _WearOSDashboardScreenState extends State<WearOSDashboardScreen> {
  _removeDataFromSharedPref() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("token");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _logoutUser() {
    setState(() {
      _removeDataFromSharedPref();
      Navigator.pushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 40,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.car_rental_sharp),
                      Text(
                        "N-Rental",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  centerTitle: true),
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            icon: const Icon(
                              Icons.person,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 48, 160, 70),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/wearosProfileScreen');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Vehicles',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            icon: const Icon(
                              Icons.drive_eta,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 170, 62, 15),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/wearosVehicleScreen');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Bookings',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            icon: const Icon(
                              Icons.book_rounded,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 223, 88, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/wearosBookingScreen');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Favourites',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            icon: const Icon(
                              Icons.bookmarks_rounded,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 161, 68, 154),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/wearosFavouriteScreen');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            icon: const Icon(
                              Icons.logout,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 81, 79, 78),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                              _logoutUser();
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            );
          },
        );
      },
    );
  }
}
