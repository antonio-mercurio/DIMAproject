import 'package:flutter/material.dart';
import 'package:prva/models/house.dart';
import 'package:prva/models/houseProfile.dart';

class HouseTile extends StatelessWidget {
  final HouseProfile house;
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
              backgroundColor: Colors.red[house.price],
            ),
            title: Text(house.type),
            subtitle: Text('Si trova a ${house.city}'),
          ),
        ));
  }
}
