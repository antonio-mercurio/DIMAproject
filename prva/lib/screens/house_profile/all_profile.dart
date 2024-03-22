import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/screens/personal_profile/show_info_personal_profile.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/shared/dialog.dart';
import 'package:prva/screens/shared/empty.dart';
import 'package:prva/screens/shared/swipe_between_images.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseFilterPerson.dart';
import 'package:prva/services/match/match_service.dart';

/* Class used by House Profile to show the Search
of the people */
class AllProfilesList extends StatefulWidget {
  final HouseProfileAdj house;

  const AllProfilesList({super.key, required this.house});

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
      return const EmptyProfile(textToShow: 'You have already seen all profiles!', shapeOfIcon: Icons.check_rounded,);
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

       return MediaQuery.of(context).size.width < widthSize
          ? Column(
          children: <Widget>[
          SwipeWidget(firstName: profiles[0].nameA, image : profiles[0].imageURL1, lastName: profiles[0].surnameA, age: _calculateAge(profiles[0]), ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(
                            MediaQuery.sizeOf(context).height * 0.02)),
                        backgroundColor: MaterialStateProperty.all(
                            mainColor), 
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return errorColor;
                          }
                          return null;
                        }),
                      ),
                  onPressed: () async {
                    /* Put like */
                    String persID = profiles[0].uidA;
                    await MatchService()
                        .putPrefence(myHouse.idHouse, persID, "like");
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
                      if (ok) {
                        if (mounted) {
                          await showMyDialog(context);
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Icon(Icons.favorite_rounded)),
              SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
              ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(
                            MediaQuery.sizeOf(context).height * 0.02)),
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return errorColor;
                          }
                          return null;
                        }),
                      ),
                  onPressed: () async {
                    await MatchService().putPrefence(
                        myHouse.idHouse, profiles[0].uidA, "dislike");
                  },
                  child: const Icon(Icons.close_rounded)),
               SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
                ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(
                            MediaQuery.sizeOf(context).height * 0.02)),
                        backgroundColor: MaterialStateProperty.all(
                            mainColor), 
                        overlayColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return errorColor;
                          }
                          return null; 
                        }),
                      ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewProfile(personalProfile: profiles[0])),
                    );
                  },
                   child: const Icon(Icons.info_rounded)),
            ],
          ),
        ],
      )
       : SingleChildScrollView(
          child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.49,
                      height: MediaQuery.sizeOf(context).height*0.9,
                      child: Column(children: <Widget>[
                       SwipeWidget(firstName: profiles[0].nameA, image : profiles[0].imageURL1, lastName: profiles[0].surnameA, age: _calculateAge(profiles[0]), ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.012),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(
                                          MediaQuery.sizeOf(context).height *
                                              0.02)),
                                  backgroundColor: MaterialStateProperty.all(
                                      mainColor), 
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return errorColor;
                                    }
                                    return null; 
                                  }),
                                ),
                                onPressed: () async {
                    /* Put like */
                    String persID = profiles[0].uidA;
                    await MatchService()
                        .putPrefence(myHouse.idHouse, persID, "like");
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
                      if (ok) {
                        if (mounted) {
                          await showMyDialog(context);
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                                child: const Icon(Icons.favorite_rounded)),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.15),
                            ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(
                                          MediaQuery.sizeOf(context).height *
                                              0.02)),
                                  backgroundColor:
                                      MaterialStateProperty.all(mainColor),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return errorColor;
                                    }
                                    return null;
                                  }),
                                ),
                                onPressed: () async {
                    await MatchService().putPrefence(
                        myHouse.idHouse, profiles[0].uidA, "dislike");
                  },
                                child: const Icon(Icons.close_rounded)),
                          ],
                        ),
                      ])),
                ),
                Expanded(
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.49,
                        height: MediaQuery.sizeOf(context).height*0.9,
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: ShowDetailedPersonalProfile(personalProfile: profiles[0]),
                          ))
                        ]))),
              ],
          )
    );}
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
