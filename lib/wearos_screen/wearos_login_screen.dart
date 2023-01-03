import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wear/wear.dart';

import '../repository/user_repository.dart';

class WearOSLoginScreen extends StatefulWidget {
  const WearOSLoginScreen({Key? key}) : super(key: key);

  @override
  State<WearOSLoginScreen> createState() => _WearOSLoginScreenState();
}

class _WearOSLoginScreenState extends State<WearOSLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _navigateToScreen(bool isLogin) {
      if (isLogin) {
        Navigator.pushReplacementNamed(context, '/wearosDashboardScreen');
      } else {
        Fluttertoast.showToast(
          msg: "Incorrect Username or password",
          fontSize: 10,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          textColor: const Color.fromARGB(255, 255, 255, 255),
        );
      }
    }

    _loginUser() async {
      try {
        UserRepository userRepository = UserRepository();
        bool isLogin = await userRepository.loginUser(
          _usernameController.text,
          _passwordController.text,
        );
        if (isLogin) {
          _navigateToScreen(true);
        } else {
          _navigateToScreen(false);
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error:${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.transparent,
          textColor: Colors.black,
        );
      }
    }

    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    usernameField(),
                    passwordField(),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          _loginUser();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget usernameField() => TextFormField(
        controller: _usernameController,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          hintText: "Enter your username",
          labelText: "Username",
        ),
      );

  Widget passwordField() => TextFormField(
        controller: _passwordController,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          hintText: "Enter your password",
          labelText: "Password",
        ),
      );
}
