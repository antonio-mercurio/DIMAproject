import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/show_info_personal_profile.dart';

PersonalProfileAdj testProfile = PersonalProfileAdj(
    day: 01,
    month: 01,
    year: 1970,
    uidA: "userTest",
    nameA: "Testname",
    surnameA: "Testsurname",
    description: "descTest",
    gender: "male",
    employment: "student",
    imageURL1: "t",
    imageURL2: "e",
    imageURL3: "s",
    imageURL4: "t");
MaterialApp app = MaterialApp(
    title: 'test',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) =>
          ShowDetailedPersonalProfile(personalProfile: testProfile)
    });
void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets('show detailed personal profile', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);
    expect(find.byKey(Key('name&surname')), findsOneWidget);
    expect(find.byKey(Key('images')), findsOneWidget);
    expect(find.byKey(Key('age')), findsOneWidget);
    expect(find.byKey(Key('description')), findsOneWidget);
    expect(find.byKey(Key('gender')), findsOneWidget);
    expect(find.byKey(Key('employment')), findsOneWidget);
  });
}
