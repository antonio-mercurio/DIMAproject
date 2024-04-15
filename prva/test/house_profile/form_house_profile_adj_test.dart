import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/house_profile/form_house_profile_adj.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/form_personal_profile_adj.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';

MaterialApp wrongDate = MaterialApp(
  title: 'withDate',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FormHouseAdj(
        startDate: DateTime(2000, 1, 1), endDate: DateTime(1999, 1, 1)),
  },
);
MaterialApp app = MaterialApp(
  title: 'withoutDate',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FormHouseAdj(),
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  final scroll = Key('scrollable');
  final type = Key('type');
  //final dropdown = Key('dropdownItems');
  final addressInput = Key('googleMapsInput');
  final description = Key('description');
  final numPeople = Key('numPeople');
  final floor = Key('floorField');
  final numBaths = Key('numBaths');
  final startdate = Key('startdate');
  final enddate = Key('enddate');
  final price = Key('price');
  final img1 = Key('img1');
  final img2 = Key('img2');
  final img3 = Key('img3');
  final img4 = Key('img4');
  final dltImg1 = Key('deleteImg1');
  final dltImg2 = Key('deleteImg2');
  final dltImg3 = Key('deleteImg3');
  final dltImg4 = Key('deleteImg4');
  final createButton = Key('createButton');

  testWidgets('Form house creation - start date < end date', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(wrongDate);

    expect(find.text('Type'), findsOneWidget);
    await tester.tap(find.byKey(type));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(Key('item-Double room')), warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    await tester.enterText(find.byKey(description), 'descriptionTest');
    await tester.enterText(find.byKey(numPeople), '3');
    await tester.enterText(find.byKey(numBaths), '2');
    await tester.enterText(find.byKey(floor), '1');
    await tester.enterText(find.byKey(price), '750.0');

    await tester.dragUntilVisible(
        find.byKey(createButton), find.byKey(scroll), const Offset(-250, 0));

    await tester.tap(find.byKey(createButton));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('End date is before start date!'), findsOneWidget);
  });
  testWidgets('Form house creation - correct population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(app);

    expect(find.byKey(scroll), findsOneWidget);
    expect(find.byKey(type), findsOneWidget);
    //expect(find.byKey(dropdown), findsOneWidget);
    expect(find.byKey(addressInput), findsOneWidget);
    expect(find.byKey(description), findsOneWidget);
    expect(find.byKey(numPeople), findsOneWidget);
    expect(find.byKey(numBaths), findsOneWidget);
    expect(find.byKey(floor), findsOneWidget);
    expect(find.byKey(startdate), findsOneWidget);
    expect(find.byKey(enddate), findsOneWidget);
    expect(find.byKey(price), findsOneWidget);
    expect(find.byKey(createButton), findsOneWidget);
    expect(find.byKey(img1), findsOneWidget);
    expect(find.byKey(img2), findsOneWidget);
    expect(find.byKey(img3), findsOneWidget);
    expect(find.byKey(img4), findsOneWidget);
    expect(find.byKey(dltImg1), findsNothing);
    expect(find.byKey(dltImg2), findsNothing);
    expect(find.byKey(dltImg3), findsNothing);
    expect(find.byKey(dltImg4), findsNothing);
    await tester.dragUntilVisible(
        find.byKey(createButton), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(createButton));
    await tester.pumpAndSettle();
    expect(find.text('Please enter description'), findsOneWidget);
    expect(find.text('Please enter a valid price (range: 0-4000)'),
        findsOneWidget);
    expect(find.text('Please enter a date'), findsNWidgets(2));

    expect(find.text('Please enter a number'), findsNWidgets(3));

    await tester.dragUntilVisible(
        find.byKey(startdate), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(startdate));
    await tester.dragUntilVisible(
        find.byKey(enddate), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(enddate));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
        find.byKey(createButton), find.byKey(scroll), const Offset(-250, 0));
    await tester.tap(find.byKey(createButton));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a date'), findsNothing);
  });

  testWidgets('Form insert photos', (tester) async {
    await tester.binding.setSurfaceSize(Size(1080, 1920));

    await tester.pumpWidget(app);

    expect(find.text('Type'), findsOneWidget);
    await tester.tap(find.byKey(type));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.byKey(Key('item-Double room')), warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    await tester.tap(find.byKey(startdate));
    await tester.tap(find.byKey(enddate));

    await tester.enterText(find.byKey(description), 'descriptionTest');
    await tester.enterText(find.byKey(numPeople), '3');
    await tester.enterText(find.byKey(numBaths), '2');
    await tester.enterText(find.byKey(floor), '1');
    await tester.enterText(find.byKey(price), '750.0');

    await tester.dragUntilVisible(
        find.byKey(createButton), find.byKey(scroll), const Offset(-250, 0));

    await tester.tap(find.byKey(createButton));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('Insert the photos!'), findsOneWidget);

    await tester.dragUntilVisible(
        find.byKey(img4), find.byKey(scroll), const Offset(-250, 0));

    await tester.tap(find.byKey(img1));
    await tester.tap(find.byKey(img2));
    await tester.tap(find.byKey(img3));
    await tester.tap(find.byKey(img4));

    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
        find.byKey(createButton), find.byKey(scroll), const Offset(-250, 0));

    await tester.tap(find.byKey(createButton));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('Insert the photos!'), findsNothing);
  });
  testWidgets('Form delete photos', (tester) async {
    await tester.binding.setSurfaceSize(Size(1080, 1920));

    await tester.pumpWidget(app);

    await tester.dragUntilVisible(
        find.byKey(img4), find.byKey(scroll), const Offset(-250, 0));

    await tester.tap(find.byKey(img1));
    await tester.tap(find.byKey(img2));
    await tester.tap(find.byKey(img3));
    await tester.tap(find.byKey(img4));

    await tester.pumpAndSettle();

    await tester.tap(find.byKey(dltImg1));
    await tester.tap(find.byKey(dltImg3));
    await tester.tap(find.byKey(dltImg2));
    await tester.tap(find.byKey(dltImg4));
    await tester.pump();
  });
}
