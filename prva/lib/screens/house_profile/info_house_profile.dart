import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/shared/image.dart';
import 'package:prva/services/map/maps.dart';

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
    getImages(houseProfile.imageURL1, houseProfile.imageURL2,
        houseProfile.imageURL3, houseProfile.imageURL4);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text(houseProfile.type,
              style: GoogleFonts.plusJakartaSans(
                fontSize: size24(context),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.4,
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
            style: GoogleFonts.plusJakartaSans(
              fontSize: size18(context),
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.address,
            style: GoogleFonts.plusJakartaSans(
              fontSize: size16(context),
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            houseProfile.description,
            maxLines: 100,
            style: GoogleFonts.plusJakartaSans(
              fontSize: size16(context),
              color: Colors.black,
            ),
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
            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
            child: ElevatedButton(
              onPressed: () {
                LatLng houseLocation =
                    LatLng(houseProfile.latitude, houseProfile.longitude);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MapSample2(location: houseLocation)),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(230, 52),
                backgroundColor: mainColor,
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                side: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                'Go to the map!',
                style: GoogleFonts.plusJakartaSans(
                  color: backgroundColor,
                  fontSize: size16(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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
                'Floor Number:',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                houseProfile.floorNumber.toString(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                ),
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                houseProfile.numBath.toString(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                ),
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                houseProfile.numPlp.toString(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                ),
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${houseProfile.startDay}/${houseProfile.startMonth}/${houseProfile.startYear}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                ),
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${houseProfile.endDay}/${houseProfile.endMonth}/${houseProfile.endYear}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size16(context),
                  color: Colors.black,
                ),
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
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size20(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "${houseProfile.price}€",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size20(context),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
