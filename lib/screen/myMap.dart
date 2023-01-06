import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  LatLng myLocation = const LatLng(27.704649, 85.329569);
//  LatLng florida = const LatLng(57.5681266, -94.26746);
  @override
  void initState() {
    markers.add(
      Marker(
        markerId: MarkerId(myLocation.toString()),
        position: myLocation,
        infoWindow: const InfoWindow(
          title: '1 BHK',
          snippet: "Rs. 23000",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Room Location")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/05/2c/f9/deluxe-room.jpg?w=700&h=-1&s=1',
              height: 400,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "1 BHK | 23000",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 400,
              child: GoogleMap(
                  zoomGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: myLocation,
                    zoom: 20,
                  ),
                  markers: markers,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
