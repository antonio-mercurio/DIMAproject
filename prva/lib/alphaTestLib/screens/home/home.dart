import 'package:flutter/material.dart';
import 'package:prva/alphaTestLib/screens/login/login_screen.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/user_homepage.dart';
import 'package:prva/alphaTestLib/screens/house_profile/show_all_my_house_profile.dart';

bool showSignIn = true;
void toggleView() {
  showSignIn = !showSignIn;
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: () => {},
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[
            TextButton.icon(
              key: Key("logout"),
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                toggleView();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                          toggleView: toggleView, key: Key('loginpage'))),
                );
              },
            ),
          ],
          title: Center(
              child: Text('Affinder', style: TextStyle(color: Colors.white))),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: InkWell(
                    key: Key('personalButton'),
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserHomepage(
                                tablet: false, key: Key('userhomepage'))),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('assets/casa.jpg').image,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                          child: Text(
                            'Cerchi casa?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: InkWell(
                    key: Key('houseButton'),
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowHomeProfile(
                                  key: Key('showhomeprofile'),
                                  tablet: false,
                                )),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('assets/casa.jpg').image,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                          child: Text(
                            'Offri casa?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
