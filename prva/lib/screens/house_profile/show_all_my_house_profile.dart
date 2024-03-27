import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/screens/house_profile/form_house_profile_adj.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/house_profile/homepage_house_profile.dart';
import 'package:provider/provider.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/shared/empty.dart';
import 'package:prva/services/databaseForHouseProfile.dart';


//When clicking  on "offer an house", it will show all your house profile
//or you can create a new house profile
class ShowHomeProfile extends StatelessWidget {
  const ShowHomeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    return StreamProvider<List<HouseProfileAdj>>.value(
      value: DatabaseServiceHouseProfile(user.uid).getHousesAdj,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
          actions: <Widget>[
            (MediaQuery.sizeOf(context).width<widthSize) ?
            IconButton(
                icon: Icon(Icons.add_home_outlined,
                color: Colors.white,
                size: MediaQuery.sizeOf(context).height * 0.03),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormHouseAdj()),
                );
              },
            )
            : const SizedBox(),
          ],
        ),
        body:  (MediaQuery.sizeOf(context).width<widthSize) 
        ? const HousesList()
        : Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.49,
                      height: MediaQuery.sizeOf(context).height*0.98,
                      child:  const HousesList(),
                  ),),
                  Expanded(
                    child: InkWell(
                      onTap:() {
                        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormHouseAdj()),
                );
                      },
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.49,
                        height: MediaQuery.sizeOf(context).height*0.98,
                        child: const EmptyProfile(shapeOfIcon: Icons.add, textToShow: 'Add a house!'),
                    )
                    ),)

              ]
        )

      ),
    );
  }
}

class HousesList extends StatefulWidget {
  const HousesList({super.key});

  @override
  State<HousesList> createState() => _HousesListState();
}

class _HousesListState extends State<HousesList> {
  @override
  Widget build(BuildContext context) {
    final houses = Provider.of<List<HouseProfileAdj>>(context);
    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return HouseTile(house: houses[index]);
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
                radius: MediaQuery.sizeOf(context).height*0.05,
                foregroundImage: Image.network(house.imageURL1).image,
              ),
              title: Text(house.type, style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF101213),
                                          fontSize: size18(context),
                                          fontWeight: FontWeight.bold
              ),),
              subtitle: Text(house.city, style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF101213),
                                          fontSize: size16(context),
              ),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HouseProfSel(house: house)),
                );
              }),
        ));
  }
}
