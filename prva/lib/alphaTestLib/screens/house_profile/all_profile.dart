import 'package:flutter/material.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/show_info_personal_profile.dart';
import 'package:prva/alphaTestLib/models/filters.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';
import 'package:prva/alphaTestLib/screens/shared/dialog.dart';
import 'package:prva/alphaTestLib/screens/shared/empty.dart';
import 'package:prva/alphaTestLib/screens/shared/swipe_between_images.dart';

/* Class used by House Profile to show the Search
of the people */
class AllProfilesList extends StatefulWidget {
  final bool tablet;
  final HouseProfileAdj house;

  const AllProfilesList({super.key, required this.house, required this.tablet});

  @override
  State<AllProfilesList> createState() =>
      _AllProfilesListState(house: house, tablet: tablet);
}

class _AllProfilesListState extends State<AllProfilesList> {
  final bool tablet;

  List<String> alreadySeenProfiles = [];
  List<PersonalProfileAdj>? profiles;
  int? notifiesOther;
  final HouseProfileAdj house;
  FiltersPersonAdj filtri = FiltersPersonAdj(
      houseID: 'houseID',
      minAge: 18,
      maxAge: 50,
      gender: 'not relevant',
      employment: 'not relevant');
  _AllProfilesListState({required this.house, required this.tablet});
  //List<PreferenceForMatch>? preferencesOther;
  List<PersonalProfileAdj> allProfiles = [
    PersonalProfileAdj(
        day: 3,
        month: 3,
        year: 2000,
        uidA: 'uidA',
        nameA: 'nameA',
        surnameA: 'surnameA',
        description: 'description',
        gender: 'female',
        employment: 'worker',
        imageURL1: 'imageURL1',
        imageURL2: 'imageURL2',
        imageURL3: 'imageURL3',
        imageURL4: 'imageURL4'),
    PersonalProfileAdj(
        day: 1,
        month: 3,
        year: 2000,
        uidA: 'uidA',
        nameA: 'nameA',
        surnameA: 'surnameA',
        description: 'description',
        gender: 'male',
        employment: 'student',
        imageURL1: 'imageURL1',
        imageURL2: 'imageURL2',
        imageURL3: 'imageURL3',
        imageURL4: 'imageURL4'),
  ];
  @override
  Widget build(BuildContext context) {
    //final allProfiles = Provider.of<List<PersonalProfileAdj>>(context);
    List<PersonalProfileAdj> profiles = allProfiles;

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
      return const EmptyProfile(
        key: Key('empty'),
        textToShow: 'You have already seen all profiles!',
        shapeOfIcon: Icons.check_rounded,
      );
    } else {
      final myHouse = HouseProfileAdj(
          owner: "owner1",
          idHouse: "idHouse1",
          type: "Single Room",
          address: "via test",
          city: "Milan",
          description: "description",
          price: 500.0,
          floorNumber: 3,
          numBath: 2,
          numPlp: 2,
          startYear: 2023,
          endYear: 2025,
          startMonth: 01,
          endMonth: 01,
          startDay: 01,
          endDay: 1,
          latitude: 43.0,
          longitude: 22.0,
          imageURL1: "",
          imageURL2: "'",
          imageURL3: "",
          imageURL4: "",
          numberNotifies: 1);

      return !tablet
          ? Column(
              children: <Widget>[
                SwipeWidget(
                  key: Key("swiper"),
                  firstName: profiles[0].nameA,
                  image: profiles[0].imageURL1,
                  lastName: profiles[0].surnameA,
                  age: _calculateAge(profiles[0]),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        key: Key("likeButton"),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.02)),
                          backgroundColor: MaterialStateProperty.all(mainColor),
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
                          putPrefence(myHouse.idHouse, persID, "like");
                          /* check for match */

                          // search if the other has seen your profile and put a like
                          var ok = checkMatch(
                              myHouse.idHouse,
                              persID,
                              /*preferencesOther,*/
                              true,
                              myHouse.numberNotifies,
                              notifiesOther);
                          if (ok) {
                            if (mounted) {
                              await showMyDialog(context);
                            }
                          }
                        },
                        child: const Icon(Icons.favorite_rounded)),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
                    ElevatedButton(
                        key: Key("dislikeButton"),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.02)),
                          backgroundColor: MaterialStateProperty.all(mainColor),
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
                          putPrefence(
                              myHouse.idHouse, profiles[0].uidA, "dislike");
                        },
                        child: const Icon(Icons.close_rounded)),
                    SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
                    ElevatedButton(
                        key: Key('infoButton'),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          padding: MaterialStateProperty.all(EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.02)),
                          backgroundColor: MaterialStateProperty.all(mainColor),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
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
                                builder: (context) => ViewProfile(
                                    key: Key('viewprofile'),
                                    personalProfile: profiles[0])),
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
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      child: Column(children: <Widget>[
                        SwipeWidget(
                          key: Key("swiper"),
                          firstName: profiles[0].nameA,
                          image: profiles[0].imageURL1,
                          lastName: profiles[0].surnameA,
                          age: _calculateAge(profiles[0]),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.012),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                                key: Key('likeButton'),
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
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return errorColor;
                                    }
                                    return null;
                                  }),
                                ),
                                onPressed: () async {
                                  /* Put like */
                                  String persID = profiles[0].uidA;
                                  putPrefence(myHouse.idHouse, persID, "like");
                                  /* check for match */

                                  // search if the other has seen your profile and put a like
                                  var ok = checkMatch(
                                      myHouse.idHouse,
                                      persID,
                                      /*preferencesOther,*/
                                      true,
                                      myHouse.numberNotifies,
                                      notifiesOther);
                                  if (ok) {
                                    if (mounted) {
                                      await showMyDialog(context);
                                    }
                                  }
                                },
                                child: const Icon(Icons.favorite_rounded)),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.15),
                            ElevatedButton(
                                key: Key('dislikeButton'),
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
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return errorColor;
                                    }
                                    return null;
                                  }),
                                ),
                                onPressed: () async {
                                  putPrefence(myHouse.idHouse, profiles[0].uidA,
                                      "dislike");
                                },
                                child: const Icon(Icons.close_rounded)),
                          ],
                        ),
                      ])),
                ),
                Expanded(
                    child: SizedBox(
                        key: Key('detailedProfile'),
                        width: MediaQuery.sizeOf(context).width * 0.49,
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Expanded(
                              child: SingleChildScrollView(
                            child: ShowDetailedPersonalProfile(
                                personalProfile: profiles[0]),
                          ))
                        ]))),
              ],
            ));
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

  void putPrefence(String uidA, String hID, String s) {
    alreadySeenProfiles?.add(hID);
    allProfiles?.remove(hID);
    profiles?.remove(hID);
  }

  checkMatch(
      String uidA,
      String hID,
//      List<PreferenceForMatch>? preferencesOther,
      bool bool,
      int hNotifies,
      int? myNotifies) {
    return true;
  }
}

class ViewProfile extends StatelessWidget {
  final PersonalProfileAdj personalProfile;

  const ViewProfile({super.key, required this.personalProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key("viewProfile"),
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: mainColor),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: SingleChildScrollView(
            child:
                ShowDetailedPersonalProfile(personalProfile: personalProfile),
          ))
        ]));
  }
}
