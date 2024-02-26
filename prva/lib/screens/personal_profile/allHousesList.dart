import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/daSpostareoCollegare/showDetailsHouseProfile.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/house_profile/all_profile_list.dart';
import 'package:prva/screens/swipe_between_images.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/show_detailed_profile.dart';
import 'package:prva/show_details_personal_profile.dart';

class AllHousesList extends StatefulWidget {
  final PersonalProfileAdj myProfile;
  const AllHousesList({required this.myProfile});

  @override
  State<AllHousesList> createState() =>
      _AllHousesListState(myProfile: myProfile);
}

class _AllHousesListState extends State<AllHousesList> {
  List<String>? alreadySeenHouses;
  List<HouseProfileAdj>? houses;
  List<PreferenceForMatch>? preferencesOther;
  final PersonalProfileAdj myProfile;
  FiltersHouseAdj? filtri;
  int? notifiesOther;
  int? myNotifies;
  _AllHousesListState({required this.myProfile});

  @override
  Widget build(BuildContext context) {
    final allHouses = Provider.of<List<HouseProfileAdj>>(context);
    final houses = List.from(allHouses);
    try {
      final retrievedFilters =
          DatabaseServiceFilters(myProfile.uidA).getFiltersAdj;
      retrievedFilters.listen((content) {
        filtri = content;
      });
    } catch (e) {
      print('exception thrown by filters');
    }
    try {
      final retrievedAlreadySeenHouses =
          DatabaseService(myProfile.uidA).getAlreadySeenProfile;
      retrievedAlreadySeenHouses.listen((content) {
        alreadySeenHouses = content;
        if (mounted) {
          setState(() {});
        }
      });
    } catch (e) {
      print('exception thrown by already seen houses');
    }

    if (alreadySeenHouses != null) {
      houses.removeWhere(
          (element) => alreadySeenHouses!.contains(element.idHouse));
    }
    if (filtri != null && houses.isNotEmpty) {
      if (filtri?.city != "any" && filtri?.city != "") {
        houses.removeWhere((element) => (filtri?.city != element.city));
      }
      if (filtri?.budget != null) {
        houses.removeWhere((element) => (filtri!.budget! < element.price));
      }
      if (filtri?.apartment == false) {
        houses.removeWhere((element) => element.type == "Apartment");
      }
      if (filtri?.singleRoom == false) {
        houses.removeWhere((element) => element.type == "Single room");
      }
      if (filtri?.doubleRoom == false) {
        houses.removeWhere((element) => element.type == "Double room");
      }
      if (filtri?.studioApartment == false) {
        houses.removeWhere((element) => element.type == "Studio apartment");
      }
      if (filtri?.twoRoomsApartment == false) {
        houses.removeWhere((element) => element.type == "Two-room apartment");
      }
    }

    if (houses.isEmpty) {
      return const Center(
        child: Text('non ci sono case da visualizzare',
            style: TextStyle(
                fontFamily: 'Outfit',
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500)),
      );
    } else {
      final myUser = Provider.of<PersonalProfileAdj>(context);
      final retrievedPreferences =
          MatchService(uid: houses[0].idHouse).getPreferencesForMatch;
      retrievedPreferences.listen((content) {
        preferencesOther = content;
      });

      final retrievedNotifiesOther =
          MatchService(uid: houses[0].idHouse).getNotification;
      retrievedNotifiesOther.listen((content) {
        notifiesOther = content;
      });

      final retrievedNotifies = MatchService(uid: myUser.uidA).getNotification;
      retrievedNotifies.listen((content) {
        myNotifies = content;
      });

      return Column(children: <Widget>[
        SwipeWidget(houseProfile: houses[0]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite_outline,
                    size: MediaQuery.sizeOf(context).height * 0.04),
                color: Colors.black,
                onPressed: () async {
                  /* Put like */
                  String hID = houses[0].idHouse;
                  await MatchService().putPrefence(myUser.uidA, hID, "like");
                  print('persona mette mi piace');
                  try {
                    final ok = await MatchService().checkMatch(myUser.uidA, hID,
                        preferencesOther, notifiesOther, myNotifies);
                    print('persona controlla match');
                    print(ok.toString());
                    if (ok) {
                      if (mounted) {
                        await showMyDialog(context);
                      }
                    }
                  } catch (e) {
                    //catch code block
                  }
                }),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
            IconButton(
                icon: Icon(Icons.close_outlined,
                    size: MediaQuery.sizeOf(context).height * 0.04),
                color: Colors.black,
                onPressed: () async {
                  await MatchService()
                      .putPrefence(myUser.uidA, houses[0].idHouse, "dislike");
                }),
            SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
            IconButton(
                icon: Icon(Icons.info,
                    size: MediaQuery.sizeOf(context).height * 0.04),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewProfile(houseProfile: houses[0])),
                  );
                }),
          ],
        ),
      ]);
    }
  }
}

class ViewProfile extends StatelessWidget {
  final HouseProfileAdj houseProfile;

  const ViewProfile({super.key, required this.houseProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: SingleChildScrollView(
            child: ShowDetailedHouseProfile(houseProfile: houseProfile),
          ))
        ]));
  }
}

class AllHousesTiles extends StatelessWidget {
  final HouseProfileAdj house;
  AllHousesTiles({required this.house});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  foregroundImage: Image.network(house.imageURL1).image,
                  radius: 25.0,
                ),
                title: Text(house.type),
                subtitle: Text('Si trova a ${house.city}'),
              ),
            ])));
  }
}
