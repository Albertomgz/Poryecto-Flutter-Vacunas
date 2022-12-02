// ignore: prefer_typing_uninitialized_variables
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.0658142, -98.1492048),
    zoom: 14.4746,
  );

  static final Marker __kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'Tu ubicación'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(19.0658142, -98.1492048),
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(19.0658142, -98.1492048),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final Marker __kImss50Marker = Marker(
    markerId: MarkerId('_kImss50'),
    infoWindow: InfoWindow(title: 'Imss cercano'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(19.0644574, -98.1590527),
  );

  static final Marker __kImss02Marker = Marker(
    markerId: MarkerId('_kImss02'),
    infoWindow: InfoWindow(title: 'Imss cercano'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(19.0395145, -98.2004743),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {__kGooglePlexMarker, __kImss50Marker, __kImss02Marker},
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Ubica tu dirección'),
        icon: Icon(Icons.location_on),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
