import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/house_profile/homepage_house_profile.dart';

class HouseTile extends StatelessWidget {
  final HouseProfileAdj house;
  HouseTile({required this.house});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                foregroundImage: Image.network(house.imageURL1).image,
              ),
              title: Text(house.type),
              subtitle: Text('Si trova a ${house.city}'),
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
