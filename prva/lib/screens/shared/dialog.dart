import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/screens/shared/constant.dart';

showMyDialog(BuildContext buildContext) {
  return showDialog<void>(
      context: buildContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return (Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.sizeOf(context).height * 0.40,
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: secondaryBackGround,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                  child: Text('You\'ve got a new match!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: size24(context),
                        color: const Color(0xFF101213),
                      ),
                      textAlign: TextAlign.center),
                ),
                Positioned(
                    top: -MediaQuery.sizeOf(context).height * 0.12,
                    child: Image.asset('assets/happy_face.png',
                        width: MediaQuery.sizeOf(context).height * 0.20,
                        height: MediaQuery.sizeOf(context).height * 0.20)),
                Positioned(
                  bottom: 10,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.sizeOf(context).height * 0.12,
                          MediaQuery.sizeOf(context).height * 0.034),
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
                      'Cool!',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: size16(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            )));
      });
}
