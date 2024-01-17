import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/home/filtersFormPerson.dart';
import 'package:prva/screens/home/form_modify_house.dart';
import 'package:prva/services/databaseFilterPerson.dart';



//When we have the list of our "house profile", when clicking on one of them show this home page
//in this home page we have the search option, which show all the people that are looking for an house
//Chat panel will show chats
//Profile panel will show your profile
class HouseProfSel extends StatefulWidget {
  final HouseProfile house;

  HouseProfSel({required this.house});

  @override
  State<HouseProfSel> createState() => _HouseProfSelState(house: house);
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
              child: FiltersFormPerson(
                uidHouse: house.idHouse,
              ),
            );
          });
    }

    return StreamProvider<HouseProfile>.value(
        value: DatabaseServiceFiltersPerson(house.idHouse).getMyHouse,
        initialData: HouseProfile(
            type: '', address: '', city: '', price: 0, owner: '', idHouse: ''),
        child: Scaffold(
          backgroundColor: Colors.orange[50],
          appBar: AppBar(
            backgroundColor: Colors.red,
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
                onPressed: () {},
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
        ));
  }
}

class SearchLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfile>(context);
    return Center(
      child: Text('SEARCH'),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfile>(context);
    return Center(
      child: Column(
        children: <Widget>[
           SizedBox(height: 20.0),
              Text(house.type,
              style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 20.0),
          SizedBox(height: 20.0),
              Text(house.address,
              style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              Text(house.city,
              style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 20.0),
              Text(house.price.toString(),
              style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 20.0),
               ElevatedButton(
                    child: Text('Modifica'),
                    onPressed: () {
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModifyHouseForm(house: house)),
                );
                    },
                  )
        ],
      )
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
