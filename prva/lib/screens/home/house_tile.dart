import 'package:flutter/material.dart';
import 'package:prva/models/house.dart';

class HouseTile extends StatelessWidget {
  final House house;
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
              backgroundColor: Colors.red[house.cap],
            ),
            title: Text(house.owner),
            subtitle: Text('Si trova a ${house.city}'),
          ),
        ));
  }
}
