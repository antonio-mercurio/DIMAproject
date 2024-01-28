import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';

class SwipeWidget extends StatelessWidget {
  final HouseProfile houseProfile;

  const SwipeWidget({super.key, required this.houseProfile});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(
                      'https://i.pinimg.com/originals/d7/75/ba/d775ba84bdb529203308b9d65c1db59f.jpg')
                  .image,
            ),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 131, 130, 130),
                  Color.fromARGB(0, 219, 225, 228),
                  Colors.black
                ],
                stops: [0, 0.5, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${houseProfile.city} - ${houseProfile.type}',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Text(
                        houseProfile.price.toString(),
                        style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          ))
    ]);
  }
}
