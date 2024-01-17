import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';

class AllHousesList extends StatefulWidget {
  const AllHousesList({super.key});

  @override
  State<AllHousesList> createState() => _AllHousesListState();
}

class _AllHousesListState extends State<AllHousesList> {
  @override
  Widget build(BuildContext context) {
    final houses = Provider.of<List<HouseProfile>>(context);
    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return AllHousesTiles(house: houses[index]);
      },
    );
  }
}

class AllHousesTiles extends StatelessWidget {
  final HouseProfile house;
  AllHousesTiles({required this.house});
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
            )));
  }
}
