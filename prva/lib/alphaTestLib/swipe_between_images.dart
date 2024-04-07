import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwipeWidget extends StatelessWidget {
  final String image = "casa.jpg";
  final String firstName;
  final String lastName;
  late final double? price;
  late final int? age;

  SwipeWidget(
      {super.key,
      required this.firstName,
      required this.lastName,
      this.price,
      this.age});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.15,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$firstName $lastName',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Text(
                        price?.toString() ?? age.toString(),
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          ))
    ]);
  }
}
