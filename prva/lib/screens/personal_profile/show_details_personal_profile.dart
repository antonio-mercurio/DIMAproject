import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/screens/house_profile/show_detailed_profile.dart';
import 'package:prva/screens/shared/constant.dart';

import 'package:prva/screens/shared/image.dart';

class DetailedPersonalProfile extends StatefulWidget {
  const DetailedPersonalProfile({super.key});

  @override
  State<DetailedPersonalProfile> createState() =>
      _DetailedPersonalProfileState();
}

class _DetailedPersonalProfileState extends State<DetailedPersonalProfile> {
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

  int _calculationAge(int year, int month, int day) {
    return (DateTime.now().difference(DateTime.utc(year, month, day)).inDays /
            365)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    final personalProfile = Provider.of<PersonalProfileAdj>(context);
    getImages(personalProfile.imageURL1, personalProfile.imageURL2,
        personalProfile.imageURL3, personalProfile.imageURL4);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
          child: Text('${personalProfile.nameA} ${personalProfile.surnameA}',
              style: TextStyle(
                fontSize: size24(context),
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 12),
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
            _calculationAge(personalProfile.year, personalProfile.month,
                    personalProfile.day)
                .toString(),
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
            personalProfile.description,
            maxLines: 100,
            style: TextStyle(
                fontSize:size16(context),
                color: Colors.black,
                fontFamily: 'Plus Jakarta Sans'),
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
                style: TextStyle(
                    fontSize: size20(context),
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                personalProfile.gender,
                style: TextStyle(
                    fontSize:size20(context),
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
                'Employment:',
                style: TextStyle(
                    fontSize: size20(context),
                    color: Colors.black,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.bold ),
              ),
              Text(
                personalProfile.employment,
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
