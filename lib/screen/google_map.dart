import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class MyMapScreen extends StatefulWidget {
  const MyMapScreen({Key? key}) : super(key: key);

  @override
  State<MyMapScreen> createState() => _MyMapScreenState();
}

class _MyMapScreenState extends State<MyMapScreen> {
  GoogleMapController? mapController;

  final Set<Marker> _markers = {};
  LatLng myLocation = const LatLng(27.7047139, 85.3295421);

  BitmapDescriptor? markerImage;
  String searchsave = "";

  @override
  void initState() {
    getLocation();
    markericon();
    _markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: const LatLng(27.7052, 85.3349),
        infoWindow: InfoWindow(
          onTap: () {
            Navigator.pushNamed(context, '/dashboardScreen');
          },
          title: "Maitidevi",
          snippet: 'Pipal Bot',
        ),
        icon: markerImage!,
      ),
    );
    super.initState();
  }

  // Custom Marker Code
  void markericon() async {
    BitmapDescriptor? markerImage1 = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/location.png');
    setState(() {
      markerImage = markerImage1;
    });
  }

  // Google Map Controller
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Get My Location Code
  void getLocation() async {
    Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  void getNewLocation() async {
    // Position? currentPosition = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition =
        const CameraPosition(target: LatLng(58.5645464, 85.654541), zoom: 20);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  // Medicine Location
  void getMedicineLocation() async {
    Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  // Search Bar Controller
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  int _medQuantity = 1;

  void _incrementCount() {
    setState(() {
      _medQuantity++;
    });
  }

  void _decrementCount() {
    setState(() {
      _medQuantity--;
    });
  }

  // // Book Medicine Controller
  // final _quantity = TextEditingController();
  // final _total_price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    );
    return Scaffold(
        body: GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: myLocation,
        // zoom: 10,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    ));
  }
}
