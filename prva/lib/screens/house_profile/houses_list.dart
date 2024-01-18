import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/house_profile/house_tile.dart';

class HousesList extends StatefulWidget {
  const HousesList({super.key});

  @override
  State<HousesList> createState() => _HousesListState();
}

class _HousesListState extends State<HousesList> {
  @override
  Widget build(BuildContext context) {
    final houses = Provider.of<List<HouseProfile>>(context);
    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return HouseTile(house: houses[index]);
      },
    );
  }
}
