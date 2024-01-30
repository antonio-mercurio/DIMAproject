import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:prva/screens/filters_people_adj.dart';
import 'package:prva/screens/house_profile/all_profile_list.dart';
import 'package:prva/screens/house_profile/filtersFormPerson.dart';
import 'package:prva/screens/house_profile/form_modify_house.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseFilterPerson.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/shared/loading.dart';
import 'package:prva/show_detailed_profile.dart';

//When we have the list of our "house profile", when clicking on one of them show this home page
//in this home page we have the search option, which show all the people that are looking for an house
//Chat panel will show chats
//Profile panel will show your profile
class HouseProfSel extends StatefulWidget {
  final HouseProfileAdj house;

  HouseProfSel({required this.house});

  @override
  State<HouseProfSel> createState() => _HouseProfSelState(house: house);
}

class _HouseProfSelState extends State<HouseProfSel> {
  final HouseProfileAdj house;
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
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: FormFiltersPeopleAdj(
                uidHouse: house.idHouse,
              ),
            );
          });
    }

    return StreamProvider<HouseProfileAdj>.value(
        value: DatabaseServiceHouseProfile(house.idHouse).getMyHouseAdj,
        initialData: HouseProfileAdj(
            type: '', address: '', city: '', price: 0.0, owner: '', idHouse: '',
            description: '', numBath: 0, numPlp: 0, floorNumber: 0, imageURL1: '',
            imageURL2: '', imageURL3: '', imageURL4: '', startDay: 0,
            startMonth: 0, startYear: 0, endDay: 0, endMonth: 0, endYear: 0
            ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
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

class SearchLayout extends StatefulWidget {
  const SearchLayout({super.key});

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfileAdj>(context);
    if (house.idHouse == "") {
      return Loading();
    }

    return StreamProvider<List<PersonalProfileAdj>>.value(
        value: DatabaseService(house.idHouse).getAllPersonalProfiles(),
        initialData: [],
        child: Scaffold(
            backgroundColor: Colors.black,
            body: AllProfilesList(
              house: house,
            )));
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfile>(context);
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailedProfile(houseProfile: house),
          ElevatedButton(
            child: Text('Modifica'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ModifyHouseForm(house: house)),
              );
            },
          )
        ],
      )))
    ]);
  }
}

class ChatLayout extends StatefulWidget {
  const ChatLayout({super.key});

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  List<String>? matches;

  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfile>(context);
    final retrievedMatch = MatchService(uid: house.idHouse).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
      if (mounted) {
        setState(() {});
      }
    });
    return _buildUserList(house, matches);
  }
}

Widget _buildUserList(HouseProfile house, List<String>? matches) {
  //print('223 homepage');
  //print(matches);
  return StreamBuilder<QuerySnapshot>(
    stream: MatchService().getChats(matches),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('error');
      }
      /*if (snapshot.connectionState == ConnectionState.waiting) {
        return Loading();
      }*/

      if (snapshot.hasData) {
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(context, doc, house))
              .toList(),
        );
      } else {
        return Center(
          child: Text("Non hai ancora match"),
        );
      }
    },
  );
}

Widget _buildUserListItem(
    BuildContext context, DocumentSnapshot document, HouseProfile house) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.blue,
                ),
                title: Text(data['name'] + " " + data['surname'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('open to start a chat!'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        senderUserID: house.idHouse,
                        receiverUserEmail: data['name'] + " " + data['surname'],
                        receiverUserID: document.reference.id,
                      ),
                    ),
                  );
                },
              )
            ],
          )));
}
