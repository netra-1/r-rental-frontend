import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nrental/utils/show_message.dart';
import 'package:nrental/utils/url.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../repository/user_repository.dart';
import '../response/user_response.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _genderController = TextEditingController();
  final _usernameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  String? gender;

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

  _updatePassword(Map<String, dynamic> password) async {
    bool isUpdated = await UserRepository().updatePassword(password);
    if (isUpdated) {
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _updateProfile(User user) async {
    bool isUpdated = await UserRepository().updateProfile(user);
    if (isUpdated) {
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(bool isUpdated) {
    if (isUpdated) {
      displaySuccessMessage(context, "Updated successfully");
      setState(() {});
    } else {
      displayErrorMessage(context, "Update Failed");
    }
  }

  Future<void> requestCameraPermission() async {
    final cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      await Permission.camera.request();
    }
  }

  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
          _updateProfileImage(img);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  _updateProfileImage(img) async {
    bool isUpdated = await UserRepository().updateProfileImage(img);
    if (isUpdated) {
      _displayMessage(isUpdated);
    } else {
      _displayMessage(isUpdated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<UserResponse?>(
              future: UserRepository().getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    User userData = snapshot.data!.data!;
                    print(userData);
                    return (userProfileDetails(userData));
                  } else {
                    return const Text("No data");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  userProfileDetails(userData) {
    return Column(
      children: [
        GestureDetector(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: userData.profile_img != null
                  ? NetworkImage('$baseUrl${userData.profile_img}')
                  : const NetworkImage(
                      'https://icg.webspace.durham.ac.uk/wp-content/uploads/sites/142/2021/04/4x5-Avatar.jpg'),
            ),
            onTap: () {
              requestCameraPermission();
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return photoPopup();
                  });
            }),
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "${userData.username}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 138, 20, 9),
          ),
        )),
        const SizedBox(
          height: 30,
        ),
        Container(
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
          child: TextFormField(
            enabled: false, //Not clickable and not editable.
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.black,
              border: InputBorder.none,
              labelText: userData.firstname != null
                  ? "${userData.firstname} ${userData.lastname}"
                  : "----------- ------------",
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              prefixIcon: const Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  Icons.person,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
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
          child: TextFormField(
            enabled: false, //Not clickable and not editable.
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.black,
              border: InputBorder.none,
              labelText: "${userData.email}",
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              prefixIcon: const Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(Icons.mail),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
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
          child: TextFormField(
            enabled: false, //Not clickable and not editable.
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.black,
              border: InputBorder.none,
              labelText: "${userData.phone}",
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              prefixIcon: const Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  Icons.call,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
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
          child: TextFormField(
            enabled: false, //Not clickable and not editable.
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.black,
              border: InputBorder.none,
              labelText: userData.address != null
                  ? "${userData.address}"
                  : "-----------",
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              prefixIcon: const Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  Icons.house,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
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
          child: TextFormField(
            enabled: false, //Not clickable and not editable.
            readOnly: true,
            decoration: InputDecoration(
              fillColor: Colors.black,
              border: InputBorder.none,
              labelText:
                  userData.gender != null ? "${userData.gender}" : "-------",
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              prefixIcon: const Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  Icons.male,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          height: 40,
          key: const ValueKey('updateFormBtn'),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
            onPressed: () {
              _setTextFieldValues(userData);
              _updateForm(context, userData);
            },
            icon: const Icon(Icons.edit_note),
            label: const Text(
              'Update Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: 350,
          height: 40,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 54, 200, 244),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
            ),
            onPressed: () {
              _changePasswordForm(context);
            },
            icon: const Icon(Icons.key_rounded),
            label: const Text(
              'Change Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  _setTextFieldValues(userData) {
    _firstnameController.text = userData.firstname ?? "";
    _lastnameController.text = userData.lastname ?? "";
    _emailController.text = userData.email ?? "";
    _phoneController.text = userData.phone ?? "";
    _addressController.text = userData.address ?? "";
    _genderController.text = userData.gender ?? "";
    _usernameController.text = userData.username;
  }

  void _updateForm(context, userData) => showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 241, 241),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _firstnameController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Firstname",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _lastnameController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Lastname",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _emailController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Email address",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.mail),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          key: const ValueKey('addressText'),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _addressController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Address",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.home),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Expanded(
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Expanded(
                    //           child: ListTile(
                    //             title: const Text("Male"),
                    //             leading: Radio(
                    //                 value: "male",
                    //                 groupValue: gender,
                    //                 onChanged: (value) {
                    //                   setState() {
                    //                     gender = value.toString();
                    //                   }
                    //                 }),
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: ListTile(
                    //             title: const Text("Female"),
                    //             leading: Radio(
                    //                 value: "female",
                    //                 groupValue: gender,
                    //                 onChanged: (value) {
                    //                   setState() {
                    //                     gender = value.toString();
                    //                   }
                    //                 }),
                    //           ),
                    //         )
                    //       ]),
                    // ),
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _genderController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Gender",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.male),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      key: const ValueKey('updateBtn'),
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        label: const Text(
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        icon: const Icon(Icons.edit_note),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          // _showNotification();
                          User user = User(
                            email: _emailController.text,
                            phone: _phoneController.text,
                            firstname: _firstnameController.text,
                            lastname: _lastnameController.text,
                            username: _usernameController.text,
                            gender: _genderController.text,
                            address: _addressController.text,
                          );
                          _updateProfile(user);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });

  void _changePasswordForm(context) => showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 241, 241),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _oldPasswordController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "Old Password",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.key),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
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
                        padding: const EdgeInsets.all(4),
                        child: TextFormField(
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 142, 142)),
                          controller: _newPasswordController,
                          decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 116, 114, 114),
                            border: InputBorder.none,
                            hintText: "New Password",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 145, 142, 142),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Icon(Icons.key),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 350,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 54, 174, 244),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        onPressed: () {
                          Map<String, dynamic> password = {
                            'old_password': _oldPasswordController.text,
                            'new_password': _newPasswordController.text
                          };
                          _updatePassword(password);
                          _logoutUser();
                        },
                        icon: const Icon(Icons.key_rounded),
                        label: const Text(
                          'Change Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });

  Widget photoPopup() => SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            SizedBox(
              width: 350,
              child: ElevatedButton.icon(
                onPressed: () {
                  _loadImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_enhance),
                label: const Text('Take Photo'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 350,
              child: ElevatedButton.icon(
                onPressed: () {
                  _loadImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.browse_gallery_sharp),
                label: const Text('Choose Photo'),
              ),
            ),
          ],
        ),
      );
}
