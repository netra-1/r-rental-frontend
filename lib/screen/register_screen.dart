import 'package:flutter/material.dart';
import 'package:nrental/model/user.dart';
import 'package:nrental/utils/show_message.dart';

import '../components/custom_shape.dart';
import '../repository/user_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _passwordController = TextEditingController();
  String password = '';
  bool isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _phoneNoController.addListener(() => setState(() {}));
  }

  _registerUser(User user) async {
    bool isRegister = await UserRepository().registerUser(user);
    if (isRegister) {
      Navigator.pushNamed(context, '/loginScreen');
      // _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(bool isRegister) {
    if (isRegister) {
      displaySuccessMessage(context, "Register success");
    } else {
      displayErrorMessage(context, "Register Failed");
    }
  }

  // Future<void> requestCameraPermission() async {
  //   final cameraStatus = await Permission.camera.status;
  //   if (cameraStatus.isDenied) {
  //     await Permission.camera.request();
  //   }
  // }

  // File? img;
  // Future _loadImage(ImageSource imageSource) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: imageSource);
  //     if (image != null) {
  //       setState(() {
  //         img = File(image.path);
  //       });
  //     } else {
  //       return;
  //     }
  //   } catch (e) {
  //     debugPrint('Failed to pick Image $e');
  //   }
  // }

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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // GestureDetector(
                //     child: CircleAvatar(
                //       radius: 40,
                //       backgroundColor: const Color.fromARGB(0, 62, 61, 61),
                //       child: ClipOval(
                //           child: img == null
                //               ? Image.network(
                //                   "https://www.nicepng.com/png/detail/136-1366211_group-of-10-guys-login-user-icon-png.png",
                //                   fit: BoxFit.cover)
                //               : Image.file(img!)),
                //     ),
                //     onTap: () {
                //       requestCameraPermission();
                //       showModalBottomSheet(
                //           context: context,
                //           builder: (BuildContext context) {
                //             return photoPopup();
                //           });
                //     }),
                const SizedBox(
                  height: 30,
                ),
                usernameField(),
                const SizedBox(
                  height: 30,
                ),
                emailField(),
                const SizedBox(
                  height: 30,
                ),
                phoneNoField(),
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
                    key: const ValueKey('signUpBtn'),
                    child: const Text(
                      'Sign Up',
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
                        User user = User(
                          email: _emailController.text,
                          phone: _phoneNoController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                        _registerUser(user);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Already Registered ?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        child: const Text(
                          'Sign In',
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
                          Navigator.pushNamed(context, '/loginScreen');
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
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     _displayMessage(false);
        //   }
        //   return null;
        // },
      );

  Widget emailField() => TextFormField(
        key: const ValueKey('email'),
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter email address",
          labelText: "Email Address",
          prefixIcon: const Icon(
            Icons.mail,
            size: 28,
          ),
          suffixIcon: _emailController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _emailController.clear(),
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

  Widget phoneNoField() => TextFormField(
        key: const ValueKey('phone'),
        keyboardType: TextInputType.number,
        controller: _phoneNoController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter phone number",
          labelText: "Phone Number",
          prefixIcon: const Icon(
            Icons.call,
            size: 28,
          ),
          suffixIcon: _phoneNoController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _phoneNoController.clear(),
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

  // Widget photoPopup() => SizedBox(
  //       height: 150,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const SizedBox(height: 8),
  //           SizedBox(
  //             width: 350,
  //             child: ElevatedButton.icon(
  //               onPressed: () {
  //                 _loadImage(ImageSource.camera);
  //               },
  //               icon: const Icon(Icons.camera_enhance),
  //               label: const Text('Take Photo'),
  //             ),
  //           ),
  //           const SizedBox(height: 8),
  //           SizedBox(
  //             width: 350,
  //             child: ElevatedButton.icon(
  //               onPressed: () {
  //                 _loadImage(ImageSource.gallery);
  //               },
  //               icon: const Icon(Icons.browse_gallery_sharp),
  //               label: const Text('Choose Photo'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
