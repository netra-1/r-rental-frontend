import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nrental/model/favourite.dart';
import 'package:nrental/repository/favourite_repository.dart';
import 'package:nrental/response/favourite_response.dart';
import 'package:nrental/utils/url.dart';

class WearOSFavouriteScreen extends StatefulWidget {
  const WearOSFavouriteScreen({Key? key}) : super(key: key);

  @override
  State<WearOSFavouriteScreen> createState() => _WearOSFavouriteScreenState();
}

class _WearOSFavouriteScreenState extends State<WearOSFavouriteScreen> {
  _deleteFavourite(favouriteId) async {
    bool isDeleted = await FavouriteRepository().deleteFavourite(favouriteId);
    print(isDeleted);
    if (isDeleted) {
      _displayMessage("Removed succefully");
    } else {
      _displayMessage("Failed !!");
    }
  }

  _displayMessage(message) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 10,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      textColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                                padding: const EdgeInsets.all(5),
                                child: favouriteCard(favourite));
                          });
                    } else {
                      return const Text("No data");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 54, 117, 244)),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget favouriteCard(favourite) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
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
              padding: const EdgeInsets.all(1),
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark_remove,
                  color: Colors.red,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _deleteFavourite(favourite.id);
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Image.network(
              '$baseUrl${favourite.vehicle_id.vehicle_image}',
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    " ${favourite.vehicle_id.vehicle_name}",
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Divider(
                  color: Color.fromARGB(179, 95, 94, 94),
                ),
                const SizedBox(
                  height: 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Description: ${favourite.vehicle_id.vehicle_desc}",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 126, 125, 125),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    " Rs ${favourite.vehicle_id.booking_cost}/day",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
