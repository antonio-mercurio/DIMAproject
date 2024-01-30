import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/multipleImagePicker.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseFilterPerson.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/swipe_betweeen_images_profile.dart';

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
        print('filtri ci sono');
        print(filtri!.maxAge.toString());
        print(filtri!.gender.toString());
        print(filtri!.minAge.toString());
        print(filtri!.employment.toString());
        setState(() {});
      });
    } catch (e) {
      print('exception thrown by filters');
    }
    final retrievedAlreadySeenProfiles =
        DatabaseService(house.idHouse).getAlreadySeenProfile;
    retrievedAlreadySeenProfiles.listen((content) {
      alreadySeenProfiles = content;
    });

    //print(profiles[0].nameA);
    //check already seen != null prima di fare questo filtri
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
      return Center(
        child: Text(
          'non ci sono profili da visualizzare',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      setState(() {});
      final myHouse = Provider.of<HouseProfile>(context);
      final retrievedPreferences =
          MatchService(uid: profiles[0].uidA).getPreferencesForMatch;
      retrievedPreferences.listen((content) {
        //print("r71 allProfileList");
        preferencesOther = content;
      });
      return Column(
        children: <Widget>[
          SwipePersonalWidget(personalProfile: profiles[0]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.favorite_outline,
                      size: MediaQuery.sizeOf(context).height * 0.04),
                  color: Colors.white,
                  onPressed: () async {
                    /* Put like */
                    //print("like");
                    String persID = profiles[0].uidA;
                    await MatchService()
                        .putPrefence(myHouse.idHouse, persID, "like");

                    /* check fot match */
                    try {
                      final ok = await MatchService().checkMatch(
                          myHouse.idHouse, persID, preferencesOther);
                      if (ok) {
                        if (mounted) {
                          //print('sono qui all prof 89');
                          await showMyDialog(context);
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                    //print(ok);
                    //print('match creato r86 allprof');

                    /* search if the other has seen your profile and put a like */
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
    final myHouse = Provider.of<HouseProfile>(context);
    /*final retrievedPreferences =
        MatchService(uid: profile.uid).getPreferencesForMatch;
    retrievedPreferences.listen((content) {
      print("r71 allProfileList");
      preferencesOther = content;
    });*/
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.red,
                ),
                title: Text(profile.nameA + " " + profile.surnameA),
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.favorite_outline),
                      onPressed: () async {
                        /* Put like */
                        print("like");
                        await MatchService()
                            .putPrefence(myHouse.idHouse, profile.uid, "like");

                        /* check fot match */
                        final ok = await MatchService().checkMatch(
                            myHouse.idHouse, profile.uid, preferencesOther);
                        print(ok);
                        print('match creato anche in questo modo');
                        if (ok) {
                          /* Navigator.push(context,MaterialPageRoute(
                               builder: (context) => MultipleImagePicker()));*/
                          /*AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                body: const Center(child: Text(
                                  'Ops... hai ricevuto un match! Vai nelle chat per inziiare una conversazione!',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                  ),),
                                  btnOkOnPress: () {},).show();*/
                        }
                      }
                      /* search if the other has seen your profile and put a like */
                      ),
                  const SizedBox(width: 8),
                  IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await MatchService().putPrefence(
                            myHouse.idHouse, profile.uid, "dislike");
                      }),
                  const SizedBox(width: 8),
                ],
              ),*/
            ])));
  }
}
