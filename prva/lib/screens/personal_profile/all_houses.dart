import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/screens/house_profile/showDetailsHouseProfile.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/house_profile/all_profile.dart';
import 'package:prva/screens/shared/swipe_between_images.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/shared/empty.dart';

class AllHousesList extends StatefulWidget {
  final PersonalProfileAdj myProfile;
  const AllHousesList({super.key, required this.myProfile});

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
      return const EmptyProfile(textToShow: 'You have already seen all profiles!', shapeOfIcon: Icons.check_rounded,);
    } else {
      final myUser = Provider.of<PersonalProfileAdj>(context);
      final retrievedPreferences =
          MatchService(uid: houses[0].idHouse).getPreferencesForMatch;
      retrievedPreferences.listen((content) {
        preferencesOther = content;
      });

      final retrievedNotifies = MatchService(uid: myUser.uidA).getNotification;
      retrievedNotifies.listen((content) {
        myNotifies = content;
      });

      return MediaQuery.of(context).size.width < widthSize
          ? Column(children: <Widget>[
              SwipeWidget(firstName: houses[0].type, image : houses[0].imageURL1, lastName: houses[0].city, price: houses[0].price, ),
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
                        String hID = houses[0].idHouse;
                        int hNotifies = houses[0].numberNotifies;
                        await MatchService()
                            .putPrefence(myUser.uidA, hID, "like");
                        try {
                          final ok = await MatchService().checkMatch(
                              myUser.uidA,
                              hID,
                              preferencesOther,
                              false,
                              hNotifies,
                              myNotifies);
                          if (ok) {
                            if (mounted) {
                              await showMyDialog(context);
                            }
                          }
                        } catch (e) {
                          //catch code block
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
                            myUser.uidA, houses[0].idHouse, "dislike");
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
                                  ViewProfile(houseProfile: houses[0])),
                        );
                      },
                      child: const Icon(Icons.info_rounded))
                ],
              ),
            ])
          : SingleChildScrollView(
          child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.49,
                      height: MediaQuery.sizeOf(context).height*0.9,
                      child: Column(children: <Widget>[
                       SwipeWidget(firstName: houses[0].type, image : houses[0].imageURL1, lastName: houses[0].city, price: houses[0].price, ),
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
                                  String hID = houses[0].idHouse;
                                  int hNotifies = houses[0].numberNotifies;
                                  await MatchService()
                                      .putPrefence(myUser.uidA, hID, "like");
                                  try {
                                    final ok = await MatchService().checkMatch(
                                        myUser.uidA,
                                        hID,
                                        preferencesOther,
                                        false,
                                        hNotifies,
                                        myNotifies);
                                    if (ok) {
                                      if (mounted) {
                                        await showMyDialog(context);
                                      }
                                    }
                                  } catch (e) {
                                    //catch code block
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
                                  await MatchService().putPrefence(myUser.uidA,
                                      houses[0].idHouse, "dislike");
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
                            child: ShowDetailedHouseProfile(
                                houseProfile: houses[0]),
                          ))
                        ]))),
              ],
          )
    );}
  }
}

class ViewProfile extends StatelessWidget {
  final HouseProfileAdj houseProfile;

  const ViewProfile({super.key, required this.houseProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: mainColor),
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
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
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
