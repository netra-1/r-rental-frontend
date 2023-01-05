import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nrental/screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? data;
  bool? isLoggedIn;
  @override
  void initState() {
    _getDataFromSharedPref();
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => {
              if (isLoggedIn == false)
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                }
              else
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardScreen()))
                }
            });
  }

  _getDataFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString("token");
    if (prefs.containsKey('token')) {
      setState(() {
        data = value;
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/room.jpg",
                    height: 500.0,
                    width: 350.0,
                    fit: BoxFit.fitWidth,
                  ),
                  const CircularProgressIndicator(
                    color: Color.fromARGB(255, 58, 176, 254),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
