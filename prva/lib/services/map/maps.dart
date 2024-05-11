import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';

class MapSample2 extends StatefulWidget {
  final LatLng location;
  const MapSample2({super.key, required this.location});

  @override
  State<MapSample2> createState() => _MapSample2State(location);
}

class _MapSample2State extends State<MapSample2> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  LatLng location;

  _MapSample2State(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: mainColor),
        body: GoogleMap(
          mapType: MapType.normal,
          compassEnabled: true,
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 20,
          ),
          onMapCreated: (controller) {
            _mapController = controller;
            addMarker('test', location);
          },
          markers: _markers.values.toSet(),
        ));
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'Title of place',
        snippet: 'description of the location',
      ),
    );
    _markers[id] = marker;

    setState(() {});
  }
}
