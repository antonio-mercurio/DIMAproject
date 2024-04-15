import 'package:flutter/material.dart';
import 'package:prva/alphaTestLib/info_house_profile.dart';
import 'package:prva/alphaTestLib/screens/shared/swipe_between_images.dart';
import 'package:prva/alphaTestLib/models/filters.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';
import 'package:prva/alphaTestLib/models/preference.dart';
import 'package:prva/alphaTestLib/screens/shared/dialog.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';
import 'package:prva/alphaTestLib/screens/shared/empty.dart';

class AllHousesList extends StatefulWidget {
  final bool tablet;
  final PersonalProfileAdj myProfile;
  const AllHousesList(
      {super.key, required this.myProfile, required this.tablet});

  @override
  State<AllHousesList> createState() =>
      _AllHousesListState(myProfile: myProfile, tablet: tablet);
}

class _AllHousesListState extends State<AllHousesList> {
  final bool tablet;
  List<String> alreadySeenHouses = [];
  List<HouseProfileAdj>? houses;
  final PersonalProfileAdj myProfile;
  FiltersHouseAdj filtri = FiltersHouseAdj(
      userID: "userID",
      city: "Milan",
      apartment: false,
      studioApartment: true,
      singleRoom: false,
      doubleRoom: true,
      twoRoomsApartment: true,
      budget: 4000.0);
  int? myNotifies;
  _AllHousesListState({required this.myProfile, required this.tablet});
  HouseProfileAdj test1 = HouseProfileAdj(
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
  HouseProfileAdj test2 = HouseProfileAdj(
      owner: "owner2",
      idHouse: "idHouse2",
      type: "Double Room",
      address: "via test2",
      city: "Rome",
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
      numberNotifies: 0);
  List<HouseProfileAdj> allHouses = [
    HouseProfileAdj(
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
        numberNotifies: 1),
    HouseProfileAdj(
        owner: "owner2",
        idHouse: "idHouse2",
        type: "Double Room",
        address: "via test2",
        city: "Rome",
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
        numberNotifies: 0)
  ];

  @override
  Widget build(BuildContext context) {
    List<HouseProfileAdj> houses = List.from(allHouses);

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
      return const EmptyProfile(
        textToShow: 'You have already seen all profiles!',
        shapeOfIcon: Icons.check_rounded,
      );
    } else {
      final myUser = PersonalProfileAdj(
          day: 01,
          month: 01,
          year: 2000,
          uidA: "testUser",
          nameA: "name",
          surnameA: "surname",
          description: "description",
          gender: "male",
          employment: "student",
          imageURL1: "",
          imageURL2: "",
          imageURL3: "",
          imageURL4: "");

      myNotifies = 1;

      return !tablet
          ? Column(children: <Widget>[
              SwipeWidget(
                key: Key("swiper"),
                firstName: houses[0].type,
                image: houses[0].imageURL1,
                lastName: houses[0].city,
                price: houses[0].price,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.012),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      key: Key("likeButton"),
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
                        /* Put like */
                        String hID = houses[0].idHouse;
                        int hNotifies = houses[0].numberNotifies;
                        putPrefence(myUser.uidA, hID, "like");
                        var ok = checkMatch(myUser.uidA, hID, null, false,
                            hNotifies, myNotifies);
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
                        putPrefence(myUser.uidA, houses[0].idHouse, "dislike");
                      },
                      child: const Icon(Icons.close_rounded)),
                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.15),
                  ElevatedButton(
                      key: Key('infoButton'),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/viewprofile');
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
                      height: MediaQuery.sizeOf(context).height * 0.9,
                      child: Column(children: <Widget>[
                        SwipeWidget(
                          key: Key("swiper"),
                          firstName: houses[0].type,
                          image: houses[0].imageURL1,
                          lastName: houses[0].city,
                          price: houses[0].price,
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
                                  String hID = houses[0].idHouse;
                                  int hNotifies = houses[0].numberNotifies;
                                  putPrefence(myUser.uidA, hID, "like");
                                  var ok = checkMatch(myUser.uidA, hID, null,
                                      false, hNotifies, myNotifies);
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
                                  putPrefence(myUser.uidA, houses[0].idHouse,
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
                            child: ShowDetailedHouseProfile(
                                houseProfile: houses[0]),
                          ))
                        ]))),
              ],
            ));
    }
  }

  void putPrefence(String uidA, String hID, String s) {
    alreadySeenHouses?.add(hID);
    allHouses?.remove(hID);
    houses?.remove(hID);
  }

  checkMatch(
      String uidA,
      String hID,
      List<PreferenceForMatch>? preferencesOther,
      bool bool,
      int hNotifies,
      int? myNotifies) {
    return true;
  }
}

class ViewProfile extends StatelessWidget {
  final HouseProfileAdj houseProfile;

  const ViewProfile({super.key, required this.houseProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key("viewProfile"),
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
        key: Key('listTile'),
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
            margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25.0,
                ),
                title: Text(house.type),
                subtitle: Text('Si trova a ${house.city}'),
              ),
            ])));
  }
}
