import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/services/map/maps.dart';

import '../shared/image.dart';

class DetailedHouseProfile extends StatefulWidget {
  //final HouseProfileAdj houseProfile;

  const DetailedHouseProfile({
    super.key,
    /*required this.houseProfile*/
  });

  @override
  State<DetailedHouseProfile> createState() =>
      _DetailedHouseProfileState(/*houseProfile: houseProfile*/);
}

class _DetailedHouseProfileState extends State<DetailedHouseProfile> {
  //final HouseProfileAdj houseProfile;
  List<String> images = [];
  bool flag = true;

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

  //_DetailedProfileState({required this.houseProfile});

  @override
  Widget build(BuildContext context) {
    final houseProfile = Provider.of<HouseProfileAdj>(context);
     getImages(houseProfile.imageURL1, houseProfile.imageURL2,
        houseProfile.imageURL3, houseProfile.imageURL4);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text(houseProfile.type,
              style: TextStyle(
                fontSize: size24(context),
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height*0.4,
            decoration: const BoxDecoration(
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
            style: TextStyle(
              fontSize: size18(context),
              color: Colors.black,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.address,
            style: TextStyle(
                fontSize: size16(context),
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans'),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.description,
            maxLines: 100,
            style: TextStyle(
                fontSize: size16(context),
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans'),
          ),
        ),
        const Divider(
          height: 36,
          thickness: 1,
          color: Colors.grey,
        ),
       Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 16),
                                      child:ElevatedButton(
            onPressed: () {
              LatLng houseLocation =
                  LatLng(houseProfile.latitude, houseProfile.longitude);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapSample2(location: houseLocation)),
              );
            },
            style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(230, 52),
                                      backgroundColor:mainColor,
                                       elevation: 3.0,
                                       shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                       ),
                                       side: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child : Text('Go to the map!',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                            color: backgroundColor,
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                    ),
                                    ),
                                    ),
                                ),),
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
               Text(
                'Floor Number:',
                style: TextStyle(
                    fontSize: size16(context),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.floorNumber.toString(),
                style: TextStyle(
                    fontSize:size16(context),
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
               Text(
                'Number of bathrooms:',
                style: TextStyle(
                    fontSize: size16(context),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.numBath.toString(),
                style: TextStyle(
                    fontSize: size16(context),
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
               Text(
                'Max number of people in the house:',
                style: TextStyle(
                    fontSize: size16(context),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.numPlp.toString(),
                style: TextStyle(
                    fontSize: size16(context),
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
               Text(
                'Start of the rent:',
                style: TextStyle(
                    fontSize: size16(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                '${houseProfile.startDay}/${houseProfile.startMonth}/${houseProfile.startYear}',
                style: TextStyle(
                    fontSize: size16(context),
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
               Text(
                'End of the rent:',
                style: TextStyle(
                    fontSize: size16(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                '${houseProfile.endDay}/${houseProfile.endMonth}/${houseProfile.endYear}',
                style: TextStyle(
                    fontSize: size16(context),
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
               Text(
                'Price:',
                style: TextStyle(
                    fontSize: size20(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans'),
              ),
              Text(
                houseProfile.price.toString(),
                style: TextStyle(
                    fontSize: size20(context),
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