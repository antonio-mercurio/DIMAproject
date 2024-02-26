import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/place_details.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';

const LatLng cLoc = LatLng(45.48319179000315, 9.224778407607825);

class ShowDetailedHouseProfile extends StatefulWidget {
  final HouseProfileAdj houseProfile;

  const ShowDetailedHouseProfile({super.key, required this.houseProfile});

  @override
  State<ShowDetailedHouseProfile> createState() =>
      _ShowDetailedHouseProfileState(houseProfile: houseProfile);
}

class _ShowDetailedHouseProfileState extends State<ShowDetailedHouseProfile> {
  final HouseProfileAdj houseProfile;
  List<String> images = [];
  bool flag = true;

  _ShowDetailedHouseProfileState({required this.houseProfile});

  void getImages(String im1, String im2, String im3, String im4) {
    if (im1 != "" && flag) {
      images.add(im1);
    }
    if (im2 != "" && flag) {
      images.add(im2);
    }
    if (im3 != "" && flag) {
      images.add(im3);
    }
    if (im4 != "" && flag) {
      images.add(im4);
    }
    flag = false;
  }

  @override
  Widget build(BuildContext context) {
    //final houseProfile = Provider.of<HouseProfileAdj>(context);
    getImages(houseProfile.imageURL1, houseProfile.imageURL2,
        houseProfile.imageURL3, houseProfile.imageURL4);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text(houseProfile.type,
              style: const TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans',
              )),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
          child: Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: Color(0xFFF1F4F8),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return ImagesTile(image: images[index]);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.city,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.address,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans'),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.description,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans'),
          ),
        ),
        const Divider(
          height: 36,
          thickness: 1,
          color: Colors.grey,
        ),
        ElevatedButton(
            onPressed: () {
              LatLng houseLocation =
                  LatLng(houseProfile.latitude, houseProfile.longitude);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapSample2(houseLocation)),
              );
            },
            child: Text('vai mappa')),
        const Divider(
          height: 36,
          thickness: 1,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Floor Number:',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.floorNumber.toString(),
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Number of bathrooms:',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.numBath.toString(),
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Max number of people in the house:',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.numPlp.toString(),
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Start of the rent:',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                '${houseProfile.startDay}/${houseProfile.startMonth}/${houseProfile.startYear}',
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'End of the rent:',
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                '${houseProfile.endDay}/${houseProfile.endMonth}/${houseProfile.endYear}',
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
            ],
          ),
        ),
        const Divider(
          height: 36,
          thickness: 1,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price:',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.price.toString(),
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImagesTile extends StatelessWidget {
  final String image;
  ImagesTile({required this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              image,
              height: 400,
              width: MediaQuery.sizeOf(context).width * 0.9,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
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
