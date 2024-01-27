import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng cLoc = LatLng(25.1193, 55.3773);

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        onMapCreated: (controller) {
          _mapController = controller;
          addMarker('test', cLoc);
        },
        initialCameraPosition: CameraPosition(
          target: cLoc,
          zoom: 23,
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(markerId: MarkerId(id), position: location);
    _markers[id] = marker;
    setState(() {});
  }
}
