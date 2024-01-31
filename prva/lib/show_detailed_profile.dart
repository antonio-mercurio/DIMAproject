import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';

class DetailedProfile extends StatefulWidget {
  final HouseProfileAdj houseProfile;

  const DetailedProfile({super.key, required this.houseProfile});

  @override
  State<DetailedProfile> createState() => _DetailedProfileState(houseProfile: houseProfile);
}

class _DetailedProfileState extends State<DetailedProfile> {
final HouseProfileAdj houseProfile;
List<String> images=[];
bool flag = true;

void getImages(String im1, String im2, String im3, String im4){
  if(im1!="" && flag){
    images.add(im1);
    
  }
  if(im2!="" && flag){
    images.add(im2);
  }
  if(im3!="" && flag) {
    images.add(im3);
  }
  if(im4!="" && flag){
    images.add(im4);
  }
  flag =false;
}


  _DetailedProfileState({required this.houseProfile});

  @override
  Widget build(BuildContext context) {
    getImages(houseProfile.imageURL1, houseProfile.imageURL2, houseProfile.imageURL3, houseProfile.imageURL4);
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
          child:
        Container(
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
                  width: MediaQuery.sizeOf(context).width *0.9,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
  }
}

