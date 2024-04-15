import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prva/alphaTestLib/screens/house_profile/show_all_my_house_profile.dart';

MaterialApp appTablet = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => ShowHomeProfile(
          tablet: true,
        )
  },
);
MaterialApp appPhone = MaterialApp(
  title: 'test',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => ShowHomeProfile(
          tablet: false,
        )
  },
);

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() {
    binding = TestWidgetsFlutterBinding.ensureInitialized();
  });
  final addHomeButton = Key('addHomeButton');
  final tabletSBox = Key('tabletSBox');
  final tabletHousesList = Key('tabletHousesList');
  final tabletSideView = Key('tabletSideView');
  final listViewBuilder = Key('listViewBuilder');

  testWidgets('mobile phone Show Home Profile - population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appPhone);

    expect(find.byKey(addHomeButton), findsOneWidget);
    expect(find.byKey(listViewBuilder), findsOneWidget);
    expect(find.byKey(tabletSBox), findsNothing);
    expect(find.byKey(tabletHousesList), findsNothing);
    expect(find.byKey(tabletSideView), findsNothing);

    await tester.tap(find.byKey(addHomeButton));
    await tester.pumpAndSettle();
  });

  testWidgets('tablet Show Home Profile - add home button', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appTablet);

    expect(find.byKey(addHomeButton), findsOneWidget);
    expect(find.byKey(listViewBuilder), findsOneWidget);
    expect(find.byKey(tabletSBox), findsOneWidget);
    expect(find.byKey(tabletHousesList), findsOneWidget);
    expect(find.byKey(tabletSideView), findsOneWidget);

    await tester.tap(find.byKey(addHomeButton));
    await tester.pumpAndSettle();
  });
  testWidgets('tablet Show Home Profile - population', (tester) async {
    await tester.binding.setSurfaceSize(Size(1024, 768));
    await tester.pumpWidget(appTablet);

    expect(find.byKey(addHomeButton), findsOneWidget);
    expect(find.byKey(listViewBuilder), findsOneWidget);
    expect(find.byKey(tabletSBox), findsOneWidget);
    expect(find.byKey(tabletHousesList), findsOneWidget);
    expect(find.byKey(tabletSideView), findsOneWidget);

    expect(find.byKey(Key('houseTile')), findsNWidgets(2));

    await tester.tap(find.byKey(Key('houseTile')).first);
  });
}
