import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:nrental/model/booking_vehicle.dart';
import 'package:nrental/model/review.dart';
import 'package:nrental/repository/booking_repository.dart';
import 'package:nrental/repository/review_repository.dart';
import 'package:nrental/response/booking_details_response.dart';
import 'package:nrental/utils/show_message.dart';
import 'package:nrental/utils/url.dart';

import '../model/booking.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  final _daysController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  DateTime pickedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _timeController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();

  getAmt() {
    // return int.parse(_amountController.text) * 100; // Converting to paisa
    return int.parse(_amountController.text) * 100;
  }

  final _reviewController = TextEditingController();
  String? ratingValue;
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

  _dateSelected() {
    _dateController.text =
        "${pickedDate.year} - ${pickedDate.month} - ${pickedDate.day}";
  }

  _timeSelected() {
    _timeController.text = "${time.hour}: ${time.minute}";
  }

  _deleteBooking(bookingId, vehicleName) async {
    bool isDeleted = await BookingRepository().deleteBooking(bookingId);
    if (isDeleted) {
      setState(() {
        Navigator.pushNamed(context, '/dashboardScreen');
      });
      _showNotification(
          vehicleName, "booking has been cancelled.", "Cancelled");
      _displayMessage(true, "Booking Cancelled");
    } else {
      Navigator.pop(context, 'ok');
      _displayMessage(false, "Cancellation Failed");
    }
  }

  _updateBooking(Booking booking, bookingId) async {
    bool isUpdated =
        await BookingRepository().updateBooking(booking, bookingId);
    if (isUpdated) {
      _displayMessage(true, "Updated Successfully!");
    } else {
      _displayMessage(false, "Update Failed !!");
    }
  }

  _addReview(Review review, vehicleId) async {
    bool success = await ReviewRepository().addReview(review, vehicleId);
    Navigator.pop(context, 'Yes');
    if (success) {
      _displayMessage(true, "Review added successfully!");
    } else {
      _displayMessage(false, "Failed to add review!!");
    }
  }

  _displayMessage(bool success, String message) {
    if (success) {
      displaySuccessMessage(context, message);
      setState(() {});
    } else {
      displayErrorMessage(context, message);
    }
  }

  _setTextFieldValues(booking) {
    _daysController.text = booking.no_of_days.toString();
    _dateController.text = booking.booking_date ?? "";
    _addressController.text = booking.address ?? "";
    _phoneController.text = booking.contact_no ?? "";
    _timeController.text = booking.booking_time ?? "";
  }

//  _updateBooking(Booking booking) async {
//     bool isUpdated = await UserRepository().updateProfile(user);
//     if (isUpdated) {
//       _displayMessage(true);
//     } else {
//       _displayMessage(false);
//     }
//   }
  _showNotification(String vehicle, String message, String type) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: counter,
        channelKey: 'basic_channel',
        title: "$vehicle $type",
        body: '$vehicle $message',
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
    String bookingId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: FutureBuilder<BookingDetailsResponse?>(
              future: BookingRepository().getBookingDetails(bookingId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    BookingVehicle bookingDetails = snapshot.data!.data!;
                    return (_bookingDetails(bookingDetails));
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

  Widget _bookingDetails(booking) => Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      '$baseUrl${booking.vehicle_id?.vehicle_image}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // const Positioned(
                //   right: 20,
                //   top: 20,
                //   child: Icon(
                //     Icons.bookmark,
                //     color: Color.fromARGB(255, 228, 224, 224),
                //   ),
                // ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      label: const Text(
                        'Update details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(
                        Icons.edit_note_outlined,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        _setTextFieldValues(booking);
                        _bookingForm(context, booking);
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      key: const ValueKey('cancelBookingBtn'),
                      label: const Text(
                        'Cancel booking',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 244, 54, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        _showCancelBookingDialog(
                            booking.id, booking.vehicle_id.vehicle_name);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: double.infinity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            height: 50,
            color: const Color(0xff41A2CD),
            child: const Text(
              'Pay With Khalti',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              KhaltiScope.of(context).pay(
                config: PaymentConfig(
                  amount: getAmt(),
                  productIdentity: 'dells-sssssg5-g5510-2021',
                  productName: 'Product Name',
                ),
                preferences: [
                  PaymentPreference.khalti,
                ],
                onSuccess: (su) {
                  // DonateModel donateModel = DonateModel(
                  //   donation_amount: int.parse(_amountController.text),
                  //   donation_category: dropdownValue,
                  //   donor_name: _donornameController.text,
                  //   donor_note: _donornoteController.text,
                  //   donor_address: _donoraddressController.text,
                  //   idx: su.idx,
                  //   token: su.token,
                  // );
                  _donationData();
                  const successsnackBar = SnackBar(
                    content: Text('Payment Successful'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(successsnackBar);
                },
                onFailure: (fa) {
                  const failedsnackBar = SnackBar(
                    content: Text('Payment Failed'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(failedsnackBar);
                },
                onCancel: () {
                  const cancelsnackBar = SnackBar(
                    content: Text('Payment Cancelled'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(cancelsnackBar);
                },
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${booking.vehicle_id!.vehicle_name}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Rs. ${booking.vehicle_id!.booking_cost}',
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
            "${booking.vehicle_id!.vehicle_desc}   Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 156, 156, 156),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Text(
          //       'No of Days: ',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w700,
          //         color: Color.fromARGB(255, 124, 123, 123),
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //     Text(
          //       '${booking.no_of_days}',
          //       style: const TextStyle(
          //         fontSize: 18,
          //         color: Color.fromARGB(255, 0, 0, 0),
          //         fontWeight: FontWeight.w700,
          //       ),
          //       textAlign: TextAlign.right,
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     const Text(
          //       'Date and Time: ',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w700,
          //         color: Color.fromARGB(255, 124, 123, 123),
          //       ),
          //       textAlign: TextAlign.left,
          //     ),
          //     Text(
          //       '${booking.booking_date}, ${booking.booking_time}',
          //       style: const TextStyle(
          //         fontSize: 18,
          //         color: Color.fromARGB(255, 0, 0, 0),
          //         fontWeight: FontWeight.w700,
          //       ),
          //       textAlign: TextAlign.right,
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Contact No: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 124, 123, 123),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${booking.contact_no}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Address: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 124, 123, 123),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${booking.address}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Status: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 124, 123, 123),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${booking.status}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ],
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
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                label: const Text(
                  'Add Review',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(
                  Icons.reviews,
                  size: 20,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 143, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
                onPressed: () {
                  ratingValue = "3";
                  _reviewController.text = "";
                  _showAddReviewDialog(booking.vehicle_id!.id);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

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
                color: Color.fromARGB(255, 58, 179, 254),
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
                color: Color.fromARGB(255, 57, 165, 248),
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

  void _bookingForm(context, bookingData) => showModalBottomSheet<void>(
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
                          'Update Booking',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        icon: const Icon(Icons.edit_note_rounded),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
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
                              vehicle_id: bookingData.vehicle_id.id);
                          _updateBooking(
                            booking,
                            bookingData.id,
                          );
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

  Future<Future<String?>> _showCancelBookingDialog(
      bookingId, vehicleName) async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Cancel Booking'),
              content:
                  const Text('Are you sure you want to cancel this booking?'),
              actions: <Widget>[
                TextButton(
                  key: const ValueKey('yesBtn'),
                  onPressed: () {
                    _deleteBooking(bookingId, vehicleName);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'No'),
                  child: const Text('No'),
                ),
              ],
            ));
  }

  Future<Future<String?>> _showAddReviewDialog(vehicleId) async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add Review'),
              content: SizedBox(
                height: 230,
                width: 300,
                child: Column(
                  children: [
                    const Text(
                      "Rate it!!",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        ratingValue = rating.toStringAsFixed(0);
                        print(ratingValue);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter Review",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        maxLines: 5,
                        controller: _reviewController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          fillColor: Colors.black,
                          border: InputBorder.none,
                          // labelText: "Enter review",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Review review = Review(
                      rating: ratingValue,
                      review: _reviewController.text,
                    );
                    _addReview(review, vehicleId);
                  },
                  child: const Text('Submit'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'No'),
                  child: const Text('Cancel'),
                ),
              ],
            ));
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }
}

_donationData() async {}
