import 'package:flutter/material.dart';
import 'package:prva/screens/house_profile/show_all_my_house_profile.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/wrapperCreationProfile.dart';
import 'package:prva/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {},
        child: Scaffold(
          key: const ValueKey("logout"),
          backgroundColor: backgroundColor,
          appBar: AppBar(
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.person,
                  color: backgroundColor,
                  size: MediaQuery.sizeOf(context).width < widthSize
                      ? MediaQuery.sizeOf(context).height * 0.03
                      : MediaQuery.sizeOf(context).height * 0.032,
                ),
                label: Text('Logout',
                    style: TextStyle(
                      color: backgroundColor,
                      fontSize: size14(context),
                    )),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
            title: Text(
              'AFFINDER',
              style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: size32(context),
                  fontWeight: FontWeight.w600,
                  wordSpacing: 2.0),
              textAlign: TextAlign.center,
            ),
            backgroundColor: mainColor,
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: MediaQuery.of(context).size.width < widthSize
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.4,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                            ),
                            child: _choice('assets/cerca_casa.jpg',
                                'Find an accommodation!', true)),
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.4,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                            ),
                            child: _choice('assets/cerca_persone.jpg',
                                'Offer an accommodation!', false)),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                          SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.49,
                              height: MediaQuery.sizeOf(context).height * 0.90,
                              child: _choice('assets/cerca_casa.jpg',
                                  'Find an accommodation!', true)),
                          SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.49,
                              height: MediaQuery.sizeOf(context).height * 0.90,
                              child: _choice('assets/cerca_persone.jpg',
                                  'Offer an accommodation!', false)),
                        ]),
            ),
          ),
        ));
  }

  Widget _choice(String picture, String phrase, bool firstChoice) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => firstChoice
                    ? const WrapperCreationProfile()
                    : const ShowHomeProfile()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                picture,
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).height * 0.4,
              ).image,
            ),
          ),
          child: Align(
            alignment: MediaQuery.of(context).size.width < widthSize
                ? const AlignmentDirectional(0, 1)
                : const AlignmentDirectional(0, 0.7),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: Text(
                phrase,
                style: GoogleFonts.rubik(
                  color: errorColor,
                  fontSize: size20(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
