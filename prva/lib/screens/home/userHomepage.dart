import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:prva/screens/home/allHousesList.dart';
import 'package:prva/screens/home/filtersForm.dart';
import 'package:prva/screens/home/filtersFormPerson.dart';
import 'package:prva/screens/home/houses_list.dart';
import 'package:prva/screens/home/showPersonalProfile.dart';
import 'package:prva/screens/registerForHouse/registerFormHouse.dart';
import 'package:prva/services/auth.dart';
import 'package:prva/services/databaseFilterPerson.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/shared/loading.dart';

class userHomepage extends StatefulWidget {
  @override
  State<userHomepage> createState() => _userHomepageState();
}

class _userHomepageState extends State<userHomepage> {
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
    final user = Provider.of<Utente>(context);
    void _showFiltersPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: FiltersForm(),
            );
          });
    }

    return Scaffold(
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
            icon: Icon(Icons.notifications),
            label: Text('Notifications'),
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
    );
  }
}

class SearchLayout extends StatefulWidget {
  const SearchLayout({super.key});

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  Filters? filtri;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    void _showFiltersPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: FiltersForm(),
            );
          });
    }

    final retrievedFilters = DatabaseServiceFilters(user.uid).getFilters;
    retrievedFilters.listen((content) {
      filtri = Filters(
          userID: content.userID,
          budget: content.budget,
          city: content.city,
          type: content.type);
      if (this.mounted) {
        setState(() {});
      }
    });
    return StreamProvider<List<HouseProfile>>.value(
        //value: DatabaseServiceHouseProfile(user.uid).getAllHouses,
        value: DatabaseServiceHouseProfile(user.uid).getFilteredHouses(filtri),
        initialData: [],
        child: Scaffold(
          body: AllHousesList(),
        ));
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return ShowPersonalProfile();
    return Center(
      child: Text('PROFILE'),
    );
  }
}

class ChatLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return _buildUserList(user);
  }

  Widget _buildUserList(Utente user) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('houseProfiles').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(context, doc, user))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(BuildContext context, DocumentSnapshot document, Utente user) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
      title: Text(data['type'] + " " + data['city']),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              senderUserID: user.uid,
              receiverUserEmail: data['type'] + " " + data['city'],
              receiverUserID: document.reference.id,
            ),
          ),
        );
      },
    );
  }
}
