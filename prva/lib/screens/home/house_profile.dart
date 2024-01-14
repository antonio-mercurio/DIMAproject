import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/home/filtersFormPerson.dart';


class HouseProfSel extends StatefulWidget {

  final HouseProfile house;

  HouseProfSel({required this.house});

  @override
  State<HouseProfSel> createState() => _HouseProfSelState(house:  house);
}

class _HouseProfSelState extends State<HouseProfSel> {
  

  final HouseProfile house;
  _HouseProfSelState({required this.house});
  
  @override
  Widget build(BuildContext context) {
    void _showFiltersPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: FiltersFormPerson(uidHouse: house.idHouse,),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
       title: Text('Personal page'),
      actions: <Widget>[
        TextButton.icon(
          icon: Icon(Icons.settings),
          label: Text('Filters'),
          onPressed: () async {
            _showFiltersPanel();
          },
        ),
        TextButton.icon(
          icon: Icon(Icons.alarm),
          label: Text('Notifies'),
          onPressed: () {
         
          },
        ),
      ],
    ),
         body: Center(
       child: Text('Hello, World!'),
       ),
  bottomNavigationBar: BottomAppBar(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {},
        ),
      ],
    ),
  ),
);
  }
}