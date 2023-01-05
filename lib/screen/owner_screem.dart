import 'package:flutter/material.dart';
import "package:curved_navigation_bar/curved_navigation_bar.dart";
import 'package:nrental/model/user.dart';
import 'package:nrental/repository/user_repository.dart';
import 'package:nrental/response/user_response.dart';
import 'package:nrental/screen/add_rooms.dart';
import 'package:nrental/screen/booking_screen.dart';
// import 'package:nrental/screen/favourite_screen.dart';
import 'package:nrental/screen/home_screen.dart';
import 'package:nrental/screen/my_added_biddings.dart';
import 'package:nrental/screen/profile_screen.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_shape.dart';
import '../utils/url.dart';

class OwnerScreen extends StatefulWidget {
  const OwnerScreen({Key? key}) : super(key: key);

  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  // int screenIndex =
  final screens = const [
    ProfileScreen(),
    // SearchScreen(),
    HomeScreen(),
    AddRooms(),
    // FavouriteScreen(),
    MyAddedBiddings(),
    BookingScreen(),
  ];
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
  void initState() {
    ShakeDetector.autoStart(onPhoneShake: () {
      _logoutUser();
    });
    super.initState();
  }

  // List<double> _accelerometerValues = <double>[];
  // final List<StreamSubscription<dynamic>> _streamSubscription =
  //     <StreamSubscription<dynamic>>[];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _streamSubscription
  //       .add(accelerometerEvents!.listen((AccelerometerEvent event) {
  //     _accelerometerValues = <double>[event.x, event.y, event.z];
  //     print(_accelerometerValues);
  //   }));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.person,
        size: 30,
      ),
      const Icon(
        Icons.search,
        size: 30,
      ),
      const Icon(
        Icons.home,
        size: 30,
      ),
      const Icon(
        Icons.bookmark_added_rounded,
        size: 30,
      ),
      const Icon(
        Icons.approval,
        size: 30,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        // drawer: const NavDrawerWidget(),
        drawer: Drawer(
          child: Material(
            color: const Color.fromARGB(255, 77, 67, 65),
            child: ListView(
              children: [
                FutureBuilder<UserResponse?>(
                    future: UserRepository().getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          User userData = snapshot.data!.data!;
                          print(userData);
                          return (userInfo(userData));
                        } else {
                          return const Text("No data");
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                        );
                      }
                    }),
                Container(
                  padding: padding,
                  child: Column(
                    children: [
                      buildMenuItem(
                        text: "Home",
                        icon: Icons.home,
                        onClicked: () => setState(() {
                          Navigator.of(context).pop();
                          index = 2;
                        }),
                      ),
                      buildMenuItem(
                        text: "Search",
                        icon: Icons.search,
                        onClicked: () => setState(() {
                          Navigator.of(context).pop();
                          index = 1;
                        }),
                      ),
                      buildMenuItem(
                        text: "Profile",
                        icon: Icons.person,
                        onClicked: () => setState(() {
                          Navigator.of(context).pop();
                          index = 0;
                        }),
                      ),
                      buildMenuItem(
                        text: "Bookings",
                        icon: Icons.car_rental,
                        onClicked: () => setState(() {
                          Navigator.of(context).pop();
                          index = 4;
                        }),
                      ),
                      buildMenuItem(
                        text: "Favourites",
                        icon: Icons.bookmark_added,
                        onClicked: () => setState(() {
                          Navigator.of(context).pop();
                          index = 3;
                        }),
                      ),
                      buildMenuItem(
                        text: "Articles",
                        icon: Icons.article,
                        onClicked: () => setState(() {
                          Navigator.pushNamed(context, '/articleScreen');
                        }),
                      ),
                      buildMenuItem(
                        text: "Switch Profile",
                        icon: Icons.article,
                        onClicked: () => setState(() {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/dashboardScreen',
                              (Route<dynamic> route) => false);
                        }),
                      ),

                      const Divider(
                        color: Colors.white70,
                      ),
                      // buildMenuItem(
                      //   text: "Settings",
                      //   icon: Icons.settings,
                      //   onClicked: () => setState(() {
                      //     Navigator.of(context).pop();
                      //     index = 6;
                      //   }),
                      // ),
                      buildMenuItem(
                        text: "About",
                        icon: Icons.info_outline,
                        onClicked: () => setState(() {
                          Navigator.pushNamed(context, '/aboutScreen');
                        }),
                      ),
                      buildMenuItem(
                        text: "Logout",
                        icon: Icons.logout_outlined,
                        onClicked: () => _logoutUser(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // extendBody: true,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              // automaticallyImplyLeading: false,
              toolbarHeight: 125,
              backgroundColor: const Color.fromARGB(0, 197, 43, 43),
              elevation: 0.0,
              flexibleSpace: ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(255, 43, 184, 255),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          "R-renal",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: screens[index],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: navigationKey,
            index: index,
            height: 60,
            backgroundColor: const Color.fromARGB(0, 215, 44, 44),
            buttonBackgroundColor: const Color.fromARGB(255, 43, 184, 255),
            color: const Color.fromARGB(255, 43, 184, 255),
            items: items,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 500),
            onTap: (index) {
              setState(() {
                this.index = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget userInfo(userData) => Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: userData.profile_img != null
                  ? NetworkImage('$baseUrl${userData.profile_img}')
                  : const NetworkImage(
                      'https://icg.webspace.durham.ac.uk/wp-content/uploads/sites/142/2021/04/4x5-Avatar.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${userData.username}",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "${userData.email}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: const TextStyle(
            color: color,
            fontSize: 18,
          )),
      onTap: onClicked,
    );
  }

  // void selectedItem(BuildContext context, int index) {
  //   Navigator.of(context).pop();
  //   int navDrawerIndex;
  //   switch (index) {
  //     case 0:
  //       navDrawerIndex = 0;
  //       Navigator.pushNamed(context, "/OwnerScreen",
  //           arguments: navDrawerIndex);
  //       break;
  //     case 1:
  //       // navDrawerIndex = 1;
  //       setState(() {
  //         index = 1;
  //       });

  //       break;
  //   }
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   for (final subscription in _streamSubscription) {
  //     subscription.cancel();
  //   }
  //   super.dispose();
  // }
}
