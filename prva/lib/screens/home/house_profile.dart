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

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SearchLayout(),
    ProfileLayout(),
    ChatLayout(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


class SearchLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('SEARCH'),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('PROFILE'),
    );
  }
}

class ChatLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('CHAT'),
    );
  }
}