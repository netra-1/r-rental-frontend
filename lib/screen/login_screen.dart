import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:nrental/utils/show_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/custom_shape.dart';
import '../repository/user_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordVisible = true;
  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() => setState(() {}));
  }

  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.pushReplacementNamed(context, '/dashboardScreen');
    } else {
      MotionToast.error(
        description: const Text("Either username and passowrd is not correct"),
      ).show(context);
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
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context);
    }
  }

  _displayMessage(bool isLogin) {
    if (isLogin) {
      displaySuccessMessage(context, "Login success");
    } else {
      displayErrorMessage(context, "Login Failed");
    }
  }

  _setDataToSharedPref(String text) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("my_key", text);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // _getDataFromSharedPref() async{
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? value =  prefs.getString("my_key");
  //   if(value!=null){
  //     setState(() {
  //       data = value;
  //     });
  //   } else{
  //     setState(() {
  //       data = "No Data found";
  //     });
  //   }
  // }

//werwerdsfsdfsdf
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 130,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 94, 196, 255),
              child: Column(
                children: const [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      "R-Rental",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 30,
                ),
                usernameField(),
                const SizedBox(
                  height: 30,
                ),
                passwordField(),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    key: const ValueKey('signInBtn'),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginUser();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Not Registered yet?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
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
                          Navigator.pushNamed(context, '/registerScreen');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameField() => TextFormField(
        key: const ValueKey('username'),
        controller: _usernameController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter your username",
          labelText: "Username",
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            size: 30,
          ),
          suffixIcon: _usernameController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _usernameController.clear(),
                ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 54, 173, 253),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textInputAction: TextInputAction.done,
      );

  Widget passwordField() => TextFormField(
        key: const ValueKey('password'),
        controller: _passwordController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter your password",
          labelText: "Password",
          prefixIcon: const Icon(
            Icons.key,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: isPasswordVisible
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 54, 173, 253),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        obscureText: isPasswordVisible,
      );
}
