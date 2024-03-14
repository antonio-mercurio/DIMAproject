import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:prva/screens/house_profile/homepage_house_profile.dart';
import 'package:prva/screens/personal_profile/showDetailsPersonalProfile.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/shared/swipe_between_images.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseFilterPerson.dart';
import 'package:prva/services/match/match_service.dart';

/* Class used by House Profile to show the Search
of the people */
class AllProfilesList extends StatefulWidget {
  final HouseProfileAdj house;

  AllProfilesList({required this.house});

  @override
  State<AllProfilesList> createState() => _AllProfilesListState(house: house);
}

class _AllProfilesListState extends State<AllProfilesList> {
  List<String>? alreadySeenProfiles;
  List<PersonalProfileAdj>? profiles;
  int? notifiesOther;
  final HouseProfileAdj house;
  FiltersPersonAdj? filtri;
  _AllProfilesListState({required this.house});
  List<PreferenceForMatch>? preferencesOther;

  @override
  Widget build(BuildContext context) {
    final allProfiles = Provider.of<List<PersonalProfileAdj>>(context);
    final profiles = List.from(allProfiles);
    try {
      final retrievedFilters =
          DatabaseServiceFiltersPerson(uid: house.idHouse).getFiltersPersonAdj;
      retrievedFilters.listen((content) {
        filtri = content;
      });
    } catch (e) {
      print('exception thrown by filters');
    }
    final retrievedAlreadySeenProfiles =
        DatabaseService(house.idHouse).getAlreadySeenProfile;
    retrievedAlreadySeenProfiles.listen((content) {
      alreadySeenProfiles = content;
      if (mounted) {
        setState(() {});
      }
    });

    if (alreadySeenProfiles != null) {
      profiles.removeWhere(
          (element) => alreadySeenProfiles!.contains(element.uidA));
    }
    if (filtri != null && profiles.isNotEmpty) {
      if (filtri?.gender != "not relevant") {
        profiles.removeWhere((element) => ((filtri?.gender != element.gender) &&
            (element.gender != "other")));
      }
      if (filtri?.employment != "not relevant" && profiles.isNotEmpty) {
        profiles.removeWhere(
            (element) => (filtri?.employment != element.employment));
      }
      if (filtri?.minAge != 1 && profiles.isNotEmpty) {
        profiles
            .removeWhere((element) => _calculateAge(element) < filtri!.minAge!);
      }
      if (filtri?.maxAge != 100 && profiles.isNotEmpty) {
        profiles
            .removeWhere((element) => _calculateAge(element) > filtri!.maxAge!);
      }
    }

    if (profiles.isEmpty) {
      return const Center(
        child: Text(
          'non ci sono profili da visualizzare',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      final myHouse = Provider.of<HouseProfileAdj>(context);
      final retrievedPreferences =
          MatchService(uid: profiles[0].uidA).getPreferencesForMatch;
      retrievedPreferences.listen((content) {
        preferencesOther = content;
      });

      final retrievedNotifiesOther =
          MatchService(uid: profiles[0].uidA).getNotification;
      retrievedNotifiesOther.listen((content) {
        notifiesOther = content;
      });

      return Column(
        children: <Widget>[
          SwipeWidget(firstName: profiles[0].nameA, image : profiles[0].imageURL1, lastName: profiles[0].surnameA, age: _calculateAge(profiles[0]), ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.favorite_outline,
                      size: MediaQuery.sizeOf(context).height * 0.04),
                  color: Colors.white,
                  onPressed: () async {
                    /* Put like */
                    String persID = profiles[0].uidA;
                    await MatchService()
                        .putPrefence(myHouse.idHouse, persID, "like");
                    print('casa mette mi piace');

                    /* check for match */
                    try {
                      // search if the other has seen your profile and put a like
                      final ok = await MatchService().checkMatch(
                          myHouse.idHouse,
                          persID,
                          preferencesOther,
                          true,
                          myHouse.numberNotifies,
                          notifiesOther);
                      print('casa controlla match');
                      print(ok.toString());
                      if (ok) {
                        if (mounted) {
                          await showMyDialog(context);
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),
              SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
              IconButton(
                  icon: Icon(Icons.close_outlined,
                      size: MediaQuery.sizeOf(context).height * 0.04),
                  color: Colors.white,
                  onPressed: () async {
                    await MatchService().putPrefence(
                        myHouse.idHouse, profiles[0].uidA, "dislike");
                  }),
              const SizedBox(width: 8),
              SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
              IconButton(
                  icon: Icon(Icons.info,
                      size: MediaQuery.sizeOf(context).height * 0.04),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewProfile(personalProfile: profiles[0])),
                    );
                  }),
            ],
          ),
        ],
      );
    }
  }

  int _calculateAge(PersonalProfileAdj element) {
    int year = element.year;
    int month = element.month;
    int day = element.day;
    return (DateTime.now().difference(DateTime.utc(year, month, day)).inDays /
            365)
        .round()
        .toInt();
  }
}

showMyDialog(BuildContext buildContext) {
  return showDialog<void>(
      context: buildContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Icon(Icons.notification_important_sharp)),
          content: const Center(child: Text('You\'ve got a new match!')),
          actions: <Widget>[
            TextButton(
              child: const Center(child: Text('Ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

class AllPersonalTiles extends StatelessWidget {
  final PersonalProfileAdj profile;
  //List<PreferenceForMatch>? preferencesOther;
  AllPersonalTiles({required this.profile});

  @override
  Widget build(BuildContext context) {
    final myHouse = Provider.of<HouseProfileAdj>(context);

    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.red,
                ),
                title: Text("${profile.nameA} ${profile.surnameA}"),
              ),
            ])));
  }
}

class ViewProfile extends StatelessWidget {
  final PersonalProfileAdj personalProfile;

  const ViewProfile({super.key, required this.personalProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.black),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: SingleChildScrollView(
            child:
                ShowDetailedPersonalProfile(personalProfile: personalProfile),
          ))
        ]));
  }
}
