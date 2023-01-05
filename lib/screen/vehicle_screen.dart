import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:nrental/model/booking.dart';
import 'package:nrental/model/vehicle.dart';
import 'package:nrental/repository/booking_repository.dart';
import 'package:nrental/repository/favourite_repository.dart';
import 'package:nrental/utils/show_message.dart';
import 'package:nrental/utils/url.dart';

import '../model/review.dart';
import '../repository/review_repository.dart';
import '../response/review_response.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final _daysController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  DateTime pickedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _timeController = TextEditingController();
  final _dateController = TextEditingController();

  _dateSelected() {
    _dateController.text =
        "${pickedDate.year} - ${pickedDate.month} - ${pickedDate.day}";
  }

  _timeSelected() {
    _timeController.text = "${time.hour}: ${time.minute}";
  }

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

  _bookVehicle(Booking booking, vehicleId, vehicleName) async {
    bool isBooked = await BookingRepository().addBooking(booking, vehicleId);
    if (isBooked) {
      _displayMessage(true, "$vehicleName booked successfully!");
      _showNotification(
          vehicleName!, booking.booking_date!, booking.booking_time!);
    } else {
      _displayMessage(false, "$vehicleName booking failed!!");
    }
  }

  _addFavourite(vehicleId) async {
    bool isAdded = await FavouriteRepository().addFavourite(vehicleId);
    if (isAdded) {
      _displayMessage(true, "Added to favourite!");
    } else {
      _displayMessage(false, "Failed to add favourite!!");
    }
  }

  _displayMessage(bool success, String message) {
    if (success) {
      displaySuccessMessage(context, message);
    } else {
      displayErrorMessage(context, message);
    }
  }

  _showNotification(String vehicle, String date, String time) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: counter,
        channelKey: 'basic_channel',
        title: "$vehicle booked",
        body: 'You have successfully booked a $vehicle for $date, $time',
      ),
    );
    setState(() {
      counter++;
    });
  }

  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    _checkNotificationEnabled();
    _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
      _proximityValue = event.proximity;
      if (_proximityValue <= 1) {
        Navigator.pushReplacementNamed(context, '/dashboardScreen');
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Vehicle vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    void _bookingForm(context) => showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 242, 238, 238),
                color: Colors.white,
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
                      _dateField(),
                      const SizedBox(
                        height: 20,
                      ),
                      _timeField(),
                      const SizedBox(
                        height: 20,
                      ),
                      _daysField(),
                      const SizedBox(
                        height: 20,
                      ),
                      _phoneField(),
                      const SizedBox(
                        height: 20,
                      ),
                      _addressField(),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          label: const Text(
                            'Confirm Booking',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          icon: const Icon(Icons.check_circle),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            Booking booking = Booking(
                              no_of_days: _daysController.text,
                              booking_date: _dateController.text,
                              booking_time: _timeController.text,
                              address: _addressController.text,
                              contact_no: _phoneController.text,
                            );

                            _bookVehicle(
                                booking, vehicle.id, vehicle.vehicle_name);

                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          '$baseUrl${vehicle.vehicle_image}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 94, 196, 255),
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          _addFavourite(vehicle.id);
                        },
                        child: const Icon(
                          Icons.bookmark_add,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          label: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          icon: const Icon(Icons.car_rental_rounded),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                          onPressed: () {
                            _bookingForm(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${vehicle.vehicle_name}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Rs. ${vehicle.booking_cost} / day',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.green),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Specifications",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 98, 98, 98),
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${vehicle.vehicle_desc}   Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 156, 156, 156),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Color.fromARGB(179, 174, 173, 173),
                thickness: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    'Reviews',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 65, 184, 243)),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.rate_review_sharp,
                    color: Color.fromARGB(255, 54, 162, 244),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<ReviewResponse?>(
                future: ReviewRepository().getReview(vehicle.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Review> lstReviews = snapshot.data!.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final review = lstReviews[index];
                            print(review);
                            return _loadReview(review);
                          });
                    } else {
                      return const Center(
                        child: Text("No data"),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
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
      ),
    );
  }

  Widget _dateField() => TextFormField(
        readOnly: true,
        controller: _dateController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "Booking Date",
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              _pickDate();
            },
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 59, 172, 243),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  Widget _timeField() => TextFormField(
        readOnly: true,
        controller: _timeController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "Booking Time",
          suffixIcon: IconButton(
            icon: const Icon(Icons.timer),
            onPressed: () {
              _pickTime();
            },
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 50, 201, 247),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  Widget _daysField() => TextFormField(
        keyboardType: TextInputType.number,
        controller: _daysController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "No of Days",
          suffixIcon: const Icon(Icons.sunny),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 54, 173, 253),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  Widget _phoneField() => TextFormField(
        keyboardType: TextInputType.number,
        controller: _phoneController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "Phone No",
          suffixIcon: const Icon(Icons.call),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 54, 173, 253),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  Widget _addressField() => TextFormField(
        controller: _addressController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: "Address",
          suffixIcon: const Icon(Icons.location_on),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 42, 171, 252),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 135, 142, 135),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
        _dateSelected();
      });
    }
  }

  _pickTime() async {
    TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (t != null) {
      setState(() {
        time = t;
        _timeSelected();
      });
    }
  }

  Widget _loadReview(review) => Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: review.user_id.profile_img != null
                          ? NetworkImage(
                              '$baseUrl${review.user_id.profile_img}')
                          : const NetworkImage(
                              'https://icg.webspace.durham.ac.uk/wp-content/uploads/sites/142/2021/04/4x5-Avatar.jpg'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${review.user_id.username}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 47, 46, 46),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("${review.rating}"),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 54, 225, 244),
                      size: 14,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
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
                      padding: const EdgeInsets.all(8),
                      child: Text("${review.review}"))),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      );

  @override
  void dispose() {
    // TODO: implement dispose
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}
