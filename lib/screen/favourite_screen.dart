import 'package:flutter/material.dart';
import 'package:nrental/model/favourite.dart';
import 'package:nrental/repository/favourite_repository.dart';
import 'package:nrental/response/favourite_response.dart';
import 'package:nrental/utils/show_message.dart';
import 'package:nrental/utils/url.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  _deleteFavourite(favouriteId) async {
    bool isDeleted = await FavouriteRepository().deleteFavourite(favouriteId);
    print(isDeleted);
    if (isDeleted) {
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(bool isDeleted) {
    if (isDeleted) {
      setState(() {});
      displaySuccessMessage(context, "Removed from favourites");
    } else {
      displayErrorMessage(context, "Booking Cancellation Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.bookmarks_rounded,
                color: Color.fromARGB(255, 54, 184, 244),
                size: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "My Favourites",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 54, 162, 244),
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
          FutureBuilder<FavouriteResponse?>(
              future: FavouriteRepository().getFavourite(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Favourite> lstFavourite = snapshot.data!.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final favourite = lstFavourite[index];
                          return Padding(
                              padding: const EdgeInsets.all(15),
                              child: favouriteCard(favourite));
                        });
                  } else {
                    return const Text("No data");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 54, 190, 244)),
                    ),
                  );
                }
              }),
        ]),
      ),
    );
  }

  Widget favouriteCard(favourite) {
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 94, 180, 255),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  _deleteFavourite(favourite.id);
                },
                child: const Icon(
                  Icons.bookmark_remove,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Image.network(
              '$baseUrl${favourite.vehicle_id.vehicle_image}',
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
                    " ${favourite.vehicle_id.vehicle_name}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 36, 150, 199)),
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
                    "Description: ${favourite.vehicle_id.vehicle_desc}",
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
                    " Rs ${favourite.vehicle_id.booking_cost}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 56, 189, 237),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/vehicleScreen',
                            arguments: favourite.vehicle_id);
                      },
                      icon: const Icon(Icons.arrow_left_outlined),
                      label: const Text('View Details'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
