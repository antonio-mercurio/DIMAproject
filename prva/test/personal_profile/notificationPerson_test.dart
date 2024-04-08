import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/models/preference.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/notificationPerson.dart';

List<MatchPeople> idmatches = [
  MatchPeople(
      userID: 'test1', otheUserID: 'test2', timestamp: Timestamp(10, 8)),
  MatchPeople(userID: 'test3', otheUserID: 'test4', timestamp: Timestamp(14, 5))
];
List<MatchPeople> emptyMatch = [];

MaterialApp emptyApp = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => NotificationPersonLayout(),
  },
);
MaterialApp app = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => NotificationPersonLayout(idmatches: idmatches),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });

  final notificationsAppbarKey = Key('notificationsText');

  testWidgets('notificationPerson empty', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(emptyApp);

    expect(find.byKey(notificationsAppbarKey), findsOneWidget);
    expect(find.byKey(Key('emptyCheck')), findsOneWidget);
  });
  testWidgets('notificationPerson not empty', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    expect(find.byKey(notificationsAppbarKey), findsOneWidget);
    expect(find.byKey(Key('emptyCheck')), findsNothing);
    expect(find.byKey(Key('scrollableList')), findsOneWidget);
  });
}
