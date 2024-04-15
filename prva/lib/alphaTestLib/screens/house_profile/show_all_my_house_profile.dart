import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/screens/house_profile/form_house_profile_adj.dart';
import 'package:prva/alphaTestLib/models/user.dart';
import 'package:prva/alphaTestLib/screens/house_profile/homepage_house_profile.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';
import 'package:prva/alphaTestLib/screens/shared/empty.dart';

//When clicking  on "offer an house", it will show all your house profile
//or you can create a new house profile
class ShowHomeProfile extends StatelessWidget {
  final bool tablet;

  ShowHomeProfile({super.key, required this.tablet});
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
    final user = Utente(uid: "userTest");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        actions: <Widget>[
          (!tablet)
              ? IconButton(
                  key: Key('addHomeButton'),
                  icon: Icon(Icons.add_home_outlined,
                      color: Colors.white,
                      size: MediaQuery.sizeOf(context).height * 0.03),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormHouseAdj()),
                    );
                  },
                )
              : const SizedBox(key: Key('tabletSBox')),
        ],
      ),
      body: (!tablet)
          ? HousesList(allHouses: allHouses)
          : Row(children: <Widget>[
              Expanded(
                key: Key('tabletHousesList'),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.49,
                  height: MediaQuery.sizeOf(context).height * 0.98,
                  child: HousesList(allHouses: allHouses),
                ),
              ),
              Expanded(
                child: InkWell(
                    key: Key('addHomeButton'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormHouseAdj()),
                      );
                    },
                    child: SizedBox(
                      key: Key('tabletSideView'),
                      width: MediaQuery.sizeOf(context).width * 0.49,
                      height: MediaQuery.sizeOf(context).height * 0.98,
                      child: const EmptyProfile(
                          shapeOfIcon: Icons.add, textToShow: 'Add a house!'),
                    )),
              )
            ]),
    );
  }
}

class HousesList extends StatefulWidget {
  List<HouseProfileAdj> allHouses;
  HousesList({super.key, required this.allHouses});

  @override
  State<HousesList> createState() => _HousesListState(houses: allHouses);
}

class _HousesListState extends State<HousesList> {
  final List<HouseProfileAdj> houses;
  _HousesListState({required this.houses});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key('listViewBuilder'),
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return HouseTile(key: Key('houseTile'), house: houses[index]);
      },
    );
  }
}

class HouseTile extends StatelessWidget {
  final HouseProfileAdj house;
  const HouseTile({super.key, required this.house});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: MediaQuery.sizeOf(context).height * 0.05,
              ),
              title: Text(
                house.type,
                style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101213),
                    fontSize: size18(context),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                house.city,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF101213),
                  fontSize: size16(context),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HouseProfSel(
                            house: house,
                            tablet: true,
                          )),
                );
              }),
        ));
  }
}
