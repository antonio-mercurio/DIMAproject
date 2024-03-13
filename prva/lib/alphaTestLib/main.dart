import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/house_profile/show_all_my_house_profile.dart';
import 'package:prva/screens/wrapper.dart';
import 'package:prva/screens/wrapperCreationProfile.dart';
import 'package:prva/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MediaQueryData.fromView(View.of(context));
if(data.size.shortestSide > 600) { // check if its bigger
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
  ]);
} else { // otherwise will be ..
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
    return StreamProvider<Utente?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => Wrapper(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/homepageUser': (context) => WrapperCreationProfile(),
          '/homepageHouse': (context) => ShowHomeProfile(),
        },
        //home: Wrapper(),
      ),
    );
  }
}
