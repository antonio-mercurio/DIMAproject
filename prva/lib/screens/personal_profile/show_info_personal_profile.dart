import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/screens/shared/constant.dart';

import 'package:prva/screens/shared/image.dart';

class ShowDetailedPersonalProfile extends StatefulWidget {
  final PersonalProfileAdj personalProfile;

  const ShowDetailedPersonalProfile({super.key, required this.personalProfile});

  @override
  State<ShowDetailedPersonalProfile> createState() =>
      _ShowDetailedPersonalProfileState(personalProfile: personalProfile);
}

class _ShowDetailedPersonalProfileState
    extends State<ShowDetailedPersonalProfile> {
  final PersonalProfileAdj personalProfile;
  List<String> images = [];
  bool flag = true;

  _ShowDetailedPersonalProfileState({required this.personalProfile});

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

  int _calculationAge(int year, int month, int day) {
    return (DateTime.now().difference(DateTime.utc(year, month, day)).inDays /
            365)
        .floor();
  }

  @override
  Widget build(BuildContext context) {
    getImages(personalProfile.imageURL1, personalProfile.imageURL2,
        personalProfile.imageURL3, personalProfile.imageURL4);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text("${personalProfile.nameA} ${personalProfile.surnameA}",
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
            _calculationAge(personalProfile.year, personalProfile.month,
                    personalProfile.day)
                .toString(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: size18(context),
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
          child: Text(
            personalProfile.description,
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
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gender:',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: size20(context),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                personalProfile.gender,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size20(context),
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
                'Employment:',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: size20(context),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                personalProfile.employment,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: size20(context),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 200),
      ],
    );
  }
}
