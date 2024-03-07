import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/message.dart';
import 'package:prva/screens/personal_profile/modifyPersonalProfile.dart';
import 'package:prva/screens/personal_profile/form_filter_people_adj.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/personal_profile/notificationPerson.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prva/screens/personal_profile/allHousesList.dart';
import 'package:prva/services/chat/chat_service.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/screens/personal_profile/show_details_personal_profile.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int _selectedIndex = 0;
  int? myNotifies;
  static List<Widget> _widgetOptions = <Widget>[
    SearchLayout(),
    ProfileLayout(),
    ChatLayout(),
  ];
  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showFiltersPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: FormFilterPeopleAdj(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

    final retrievedNotifies = MatchService(uid: user.uid).getNotification;
    retrievedNotifies.listen((content) {
      myNotifies = content;
      if (mounted) {
        setState(() {});
      }
    });

    return StreamProvider<PersonalProfileAdj>.value(
        value: DatabaseService(user.uid).persProfileDataAdj,
        initialData: PersonalProfileAdj(
            uidA: user.uid,
            nameA: '',
            surnameA: '',
            description: "",
            gender: "",
            employment: "",
            day: 0,
            month: 0,
            year: 0,
            imageURL1: '',
            imageURL2: '',
            imageURL3: '',
            imageURL4: ''),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Personal page'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () async {
                  _showFiltersPanel();
                },
              ),
              badges.Badge(
                showBadge: (myNotifies != null && myNotifies != 0),
                badgeContent: Text(myNotifies?.toString() ?? ""),
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeStyle: badges.BadgeStyle(padding: EdgeInsets.all(4)),
                onTap: () async {
                  await MatchService(uid: user.uid).createNotification(0);
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NotificationPersonLayout(profile: user.uid),
                      ),
                    );
                  }
                },
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () async {
                    await MatchService(uid: user.uid).createNotification(0);
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationPersonLayout(profile: user.uid),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: MediaQuery.sizeOf(context).height * 0.03,
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
  FiltersHouseAdj? filtri;
  List<String>? alreadySeenProfiles;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    final personalProfile = Provider.of<PersonalProfileAdj>(context);
    return StreamProvider<List<HouseProfileAdj>>.value(
        value: DatabaseServiceHouseProfile(user.uid).getAllHousesAdj,
        initialData: [],
        child: Scaffold(
          body: AllHousesList(
            myProfile: personalProfile,
          ),
        ));
  }
}

class ProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personalData = Provider.of<PersonalProfileAdj>(context);

    //return ShowPersonalProfile();

    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailedPersonalProfile(),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              child: Text('Modifica'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => modificaPersonalProfile(
                            personalProfile: personalData,
                          )),
                );
              },
            ),
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
  List<Chat>? chats;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    //restituisce quelli con chat non iniziate
    final retrievedMatch = MatchService(uid: user.uid).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
      if (mounted) {
        setState(() {});
      }
    });
    //restituisce quelli con chat iniziate
    final retrievedStartedChats = ChatService(user.uid).getStartedChats;
    retrievedStartedChats.listen((content) {
      chats = content;
      if (mounted) {
        setState(() {});
      }
    });
    //print(chats.toString());
    return Column(
        children: [_buildUserList(user, matches), _buildChatList(user, chats)]);
  }
}

Widget _buildChatList(Utente user, List<Chat>? chats) {
  if (chats != null) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
            child: Text(
              'Chats',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return _buildChatListItem(context, chats[index], user);
              },
            ),
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Text("xs"),
    );
  }
}

Widget _buildUserList(Utente user, List<String>? matches) {
  if (matches != null) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 10, 0, 0),
            child: Text(
              'Match',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              color: Color(0xFFF1F4F8),
            ),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  return _buildUserListItem(context, matches[index], user);
                }),
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Text("Non hai ancora match"),
    );
  }
}

Widget _buildChatListItem(BuildContext context, Chat chat, Utente user) {
  return StreamBuilder<HouseProfileAdj>(
      stream: DatabaseServiceHouseProfile(chat.id).getMyHouseAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final type = snapshot.data?.type ?? "";
          final city = snapshot.data?.city ?? "";
          final idHouse = snapshot.data?.idHouse;
          return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  onTap: () async {
                    await MatchService(uid: user.uid, otheruid: idHouse)
                        .resetNotification();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          senderUserID: user.uid,
                          receiverUserEmail: type + " " + city,
                          receiverUserID: snapshot.data?.idHouse ?? "",
                        ),
                      ),
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: image != ""
                        ? Image.network(
                            image,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/userPhoto.jpg',
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                  ),
                  title: Text(
                    type + " " + city,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF14181B),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    chat.lastMsg,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: (chat.unreadMsg == 0)
                      ? null
                      : Container(
                          child: Text(
                            chat.unreadMsg.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: Color(0xFF4B39EF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                ),
              ));
          /* InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      senderUserID: user.uid,
                      receiverUserEmail: type + " " + city,
                      receiverUserID: snapshot.data?.owner ?? "",
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x32000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: image != ""
                              ? Image.network(
                                  image,
                                  width: 36,
                                  height: 36,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/userPhoto.jpg',
                                  width: 36,
                                  height: 36,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type + " " + city,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        'chat iniziata',
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));*/
        } else {
          return Center(
            child: Text('no chat'),
          );
        }
      });
}

Widget _buildUserListItem(BuildContext context, String idMatch, Utente user) {
  return StreamBuilder<HouseProfileAdj>(
      stream: DatabaseServiceHouseProfile(idMatch).getMyHouseAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final type = snapshot.data?.type ?? "";
          final city = snapshot.data?.city ?? "";

          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
            child: Container(
              width: 140,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x34090F13),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        senderUserID: user.uid,
                        receiverUserEmail: type + " " + city,
                        receiverUserID: snapshot.data?.owner ?? "",
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: image != ""
                            ? Image.network(
                                image,
                                width: 60,
                                height: 20,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/userPhoto.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(
                          city,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text('no new matches'),
          );
        }
      });
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