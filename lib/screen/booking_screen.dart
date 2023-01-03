import 'package:flutter/material.dart';
import 'package:nrental/model/booking_vehicle.dart';
import 'package:nrental/repository/booking_repository.dart';
import 'package:nrental/utils/url.dart';

import '../response/booking_vehicle_response.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.house_rounded,
                  color: Color.fromARGB(255, 54, 146, 244),
                  size: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Rented Rooms",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 54, 143, 244),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // bookingCard(),
            // const SizedBox(
            //   height: 20,
            // ),
            // bookingCard(),
            FutureBuilder<BookingVehicleResponse?>(
                future: BookingRepository().getBooking(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<BookingVehicle> lstBooking = snapshot.data!.data!;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final booking = lstBooking[index];
                            return Padding(
                                padding: const EdgeInsets.all(15),
                                child: bookingCard(booking));
                          });
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
          ]),
        ),
      ),
    );
  }

  Widget bookingCard(booking) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(
              '$baseUrl${booking.vehicle_id.vehicle_image}',
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Vehicle: ${booking.vehicle_id.vehicle_name}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 98, 95, 95)),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Color.fromARGB(179, 95, 94, 94),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Description: ${booking.vehicle_id.vehicle_desc}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Booking Cost: Rs ${booking.vehicle_id.booking_cost}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Text(
                //     "No of Days: ${booking.no_of_days}",
                //     style: const TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Color.fromARGB(255, 126, 125, 125),
                //     ),
                //     textAlign: TextAlign.justify,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Text(
                //     "Date and Time: ${booking.booking_date}, ${booking.booking_time}",
                //     style: const TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: Color.fromARGB(255, 126, 125, 125),
                //     ),
                //     textAlign: TextAlign.justify,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Contact No: ${booking.contact_no}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Address: ${booking.address}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Status: ${booking.status}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      key: ValueKey(
                          'viewDetailsBtn ${booking.vehicle_id.vehicle_name}'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 94, 196, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/bookingDetailScreen',
                            arguments: booking.id);
                      },
                      icon: const Icon(Icons.arrow_left_outlined),
                      label: const Text('View Details'),
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ElevatedButton.icon(
                //       style: ElevatedButton.styleFrom(
                //         primary: Colors.green,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10), // <-- Radius
                //         ),
                //       ),
                //       onPressed: () {},
                //       icon: const Icon(Icons.edit_note_sharp),
                //       label: const Text('Update'),
                //     ),
                //     // ElevatedButton(
                //     //   style: ElevatedButton.styleFrom(
                //     //     primary: Color.fromARGB(255, 94, 196, 255),
                //     //     shape: RoundedRectangleBorder(
                //     //       borderRadius: BorderRadius.circular(10), // <-- Radius
                //     //     ),
                //     //   ),
                //     //   child: const Text(
                //     //     "Read more",
                //     //     style: TextStyle(
                //     //       fontSize: 16,
                //     //       fontWeight: FontWeight.w500,
                //     //     ),
                //     //   ),
                //     //   onPressed: () => {
                //     //     // Navigator.pushNamed(context, '/articleDetailsScreen',
                //     //     //     arguments: article)
                //     //   },
                //     // ),
                //     // ElevatedButton(
                //     //   style: ElevatedButton.styleFrom(
                //     //     primary: Color.fromARGB(255, 94, 196, 255),
                //     //     shape: RoundedRectangleBorder(
                //     //       borderRadius: BorderRadius.circular(10), // <-- Radius
                //     //     ),
                //     //   ),

                //     //   child: const Text(
                //     //     "Read more",
                //     //     style: TextStyle(
                //     //       fontSize: 16,
                //     //       fontWeight: FontWeight.w500,
                //     //     ),
                //     //   ),
                //     //   onPressed: () => {
                //     //     // Navigator.pushNamed(context, '/articleDetailsScreen',
                //     //     //     arguments: article)
                //     //   },
                //     // ),
                //     ElevatedButton.icon(
                //       style: ElevatedButton.styleFrom(
                //         primary: Color.fromARGB(255, 94, 196, 255),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10), // <-- Radius
                //         ),
                //       ),
                //       onPressed: () {},
                //       icon: const Icon(Icons.edit_note_sharp),
                //       label: const Text('Update'),
                //     ),
                //   ],
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
