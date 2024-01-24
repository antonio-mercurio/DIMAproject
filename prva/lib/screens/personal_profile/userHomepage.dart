import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:prva/screens/personal_profile/allHousesList.dart';
import 'package:prva/screens/personal_profile/filtersForm.dart';
import 'package:prva/screens/personal_profile/updatePersonalProfile.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';
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

    return StreamProvider<PersonalProfile>.value(
        value: DatabaseService(user.uid).getMyPersonalProfile,
        initialData:
            PersonalProfile(uid: user.uid, name: '', surname: '', age: 0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Personal page'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings,
                color: Colors.white),
                onPressed: () async {
                  _showFiltersPanel();
                },
              ),
             IconButton(
                icon: Icon(Icons.notifications,
                color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            iconSize:  MediaQuery.sizeOf(context).height * 0.03,
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
  Filters? filtri;
  List<String>? alreadySeenProfiles;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
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
    final personalData = Provider.of<PersonalProfile>(context);

    //return ShowPersonalProfile();

    return Scaffold(
        body: Center(
            child: Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(personalData.name, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 20.0),
        Text(personalData.surname, style: TextStyle(fontSize: 18.0)),
        SizedBox(height: 20.0),
        Text(personalData.age.toString(), style: TextStyle(fontSize: 18.0)),
        ElevatedButton(
          child: Text('Update'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatePersonalProfile(
                        personalProfile: personalData,
                      )),
            );
          },
        ),
      ],
    )));
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
    final user = Provider.of<Utente>(context);
    final retrievedMatch = MatchService(uid: user.uid).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
      if (mounted) {
        setState(() {});
      }
    });
    //print('199 user homepage');
    print(matches);
    return _buildUserList(user, matches);
  }
}

Widget _buildUserList(Utente user, List<String>? matches) {
  //print('223 homepage');
  //print(matches);
  return StreamBuilder<QuerySnapshot>(
    stream: MatchService().getChatsPers(matches),
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
              .map<Widget>((doc) => _buildUserListItem(context, doc, user))
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
    BuildContext context, DocumentSnapshot document, Utente user) {
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
/*
class ChatLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return _buildUserList(user);
  }

  Widget _buildUserList(Utente user) {
    List<String>? matches;

    final retrievedMatch = MatchService(uid: user.uid).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
    });

    return StreamBuilder<QuerySnapshot>(
      stream: MatchService().getChatsPers(matches),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(context, doc, user))
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
      BuildContext context, DocumentSnapshot document, Utente user) {
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
*/