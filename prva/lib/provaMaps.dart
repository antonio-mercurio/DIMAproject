import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

const LatLng cLoc = LatLng(45.48319179000315, 9.224778407607825);

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  TextEditingController controller = TextEditingController();
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  late LatLng selLocation;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 32, 0, 32),
              child: GooglePlaceAutoCompleteTextField(
                textEditingController: controller,
                googleAPIKey: "AIzaSyD8yblyesPc-09bye4ZF9KlO95G6RhhlmA",
                inputDecoration: InputDecoration(),
                debounceTime: 800, // default 600 ms,
                countries: ["it", "fr"], // optional by default null is set
                isLatLngRequired:
                    true, // if you required coordinates from place detail
                getPlaceDetailWithLatLng: (Prediction prediction) async {
                  // this method will return latlng with place detail
                  print("placeDetails LNG " + prediction.lng.toString());
                  print("placeDetails LAT " + prediction.lat.toString());
                  if (prediction.lng != null && prediction.lat != null) {
                    selLocation = LatLng(
                        double.parse(prediction.lat.toString()),
                        double.parse(prediction.lng.toString()));
                    var address = await GeoCoder().getAddressFromLatLng(
                        latitude: selLocation.latitude,
                        longitude: selLocation.longitude);
                    //qui accedo ad address e prendo i dettagli che mi servono

                    print('${address.addressDetails.city}');
                  }
                }, // this callback is called when isLatLngRequired is true

                itemClick: (Prediction prediction) {
                  controller.text = prediction.description!;
                  controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description!.length));
                },
                // if we want to make custom list item builder
                itemBuilder: (context, index, Prediction prediction) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(child: Text("${prediction.description ?? ""}"))
                      ],
                    ),
                  );
                },
                // if you want to add seperator between list items
                seperatedBuilder: Divider(),
                // want to show close icon
                isCrossBtnShown: true,
                // optional container padding
                containerHorizontalPadding: 10,
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapSample2(selLocation)),
                );
              },
              child: Text('vai mappa')),
        ],
      )),
    );
  }
}

class MapSample2 extends StatefulWidget {
  LatLng location;
  MapSample2(this.location);

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
    return GoogleMap(
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
    );
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
