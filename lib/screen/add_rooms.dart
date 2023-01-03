import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nrental/model/vehicle.dart';
import 'package:nrental/utils/show_message.dart';

import '../repository/user_repository.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({Key? key}) : super(key: key);

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  File? img;
  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
        // debugPrint(img!.toString());
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _companyController = TextEditingController();
  final _descController = TextEditingController();
  final _richController = TextEditingController();
  final _featuredController = TextEditingController();
  final _bookingCostController = TextEditingController();
  final _skuController = TextEditingController();

  String password = '';
  bool isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _categoryController.addListener(() => setState(() {}));
    _companyController.addListener(() => setState(() {}));
    _descController.addListener(() => setState(() {}));
    _richController.addListener(() => setState(() {}));
    _featuredController.addListener(() => setState(() {}));
    _bookingCostController.addListener(() => setState(() {}));
    _skuController.addListener(() => setState(() {}));
  }

  _registerVehicle(Vehicle vehicle, File? fileImage) async {
    bool isRegister =
        await UserRepository().registerVehicle(vehicle, fileImage);
    // (user);
    if (isRegister) {
      // Navigator.pushNamed(context, '/loginScreen');
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(bool isRegister) {
    if (isRegister) {
      displaySuccessMessage(context, "Added success");
    } else {
      displayErrorMessage(context, "Add Failed");
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_home_rounded,
                      color: Color.fromARGB(255, 54, 146, 244),
                      size: 30,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Add Listing",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 54, 143, 244),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                nameField(),
                const SizedBox(
                  height: 30,
                ),
                richField(),
                const SizedBox(
                  height: 30,
                ),
                isFeaturedField(),
                const SizedBox(
                  height: 30,
                ),
                bookingCostField(),
                const SizedBox(
                  height: 30,
                ),
                categoryField(),
                const SizedBox(
                  height: 30,
                ),
                descField(),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _loadImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Choose Image"),
                ),
                img != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(img!),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          "https://images.squarespace-cdn.com/content/v1/5aa7561885ede15b577392dc/1591981578111-ULMPB8IDQIKE0BRYKS7O/Boston+Cream.jpg?format=1500w",
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    key: const ValueKey('signUpBtn'),
                    child: const Text(
                      'Save Changes',
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
                        Vehicle vehicle = Vehicle(
                          vehicle_name: _nameController.text,
                          vehicle_category: _categoryController.text,
                          vehicle_desc: _descController.text,
                          vehicle_rich_desc: _richController.text,
                          is_featured:
                              _featuredController.text.toLowerCase() == "true",
                          booking_cost: _bookingCostController.text,
                        );
                        _registerVehicle(vehicle, img);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
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

  Widget nameField() => TextFormField(
        controller: _nameController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter room name",
          labelText: "Room Name",
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            size: 30,
          ),
          suffixIcon: _nameController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _nameController.clear(),
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

  Widget richField() => TextFormField(
        controller: _richController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Location.",
          labelText: "Location",
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            size: 30,
          ),
          suffixIcon: _richController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _richController.clear(),
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

  Widget isFeaturedField() => TextFormField(
        controller: _featuredController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter is featured",
          labelText: "Featured",
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            size: 30,
          ),
          suffixIcon: _featuredController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _featuredController.clear(),
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

  Widget bookingCostField() => TextFormField(
        controller: _bookingCostController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Booking cost",
          labelText: "Booking Cost",
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            size: 30,
          ),
          suffixIcon: _bookingCostController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _bookingCostController.clear(),
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

  Widget skuField() => TextFormField(
        controller: _skuController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter sku",
          labelText: "SKU",
          prefixIcon: const Icon(
            Icons.account_circle_sharp,
            size: 30,
          ),
          suffixIcon: _skuController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _skuController.clear(),
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

  Widget categoryField() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _categoryController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Category",
          labelText: "Category",
          prefixIcon: const Icon(
            Icons.mail,
            size: 28,
          ),
          suffixIcon: _categoryController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _categoryController.clear(),
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

  Widget companyField() => TextFormField(
        keyboardType: TextInputType.number,
        controller: _companyController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Company",
          labelText: "Company",
          prefixIcon: const Icon(
            Icons.call,
            size: 28,
          ),
          suffixIcon: _companyController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _companyController.clear(),
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

  Widget descField() => TextFormField(
        controller: _descController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: "Enter Desc",
          labelText: "Desc..",
          prefixIcon: const Icon(
            Icons.key,
            size: 30,
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
