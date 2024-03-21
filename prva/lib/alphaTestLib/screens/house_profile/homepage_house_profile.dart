import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/message.dart';
import 'package:prva/screens/house_profile/modifyHouseProfile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:prva/screens/house_profile/filters_people_adj.dart';
import 'package:prva/screens/house_profile/all_profile.dart';
import 'package:prva/screens/house_profile/notification.dart';
import 'package:prva/services/chat/chat_service.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/screens/shared/loading.dart';
import 'package:prva/screens/house_profile/show_detailed_profile.dart';

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
  int? myNotifies;

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

  @override
  Widget build(BuildContext context) {
    final retrievedNotifies =
        DatabaseServiceHouseProfile(house.idHouse).getNotification;
    retrievedNotifies.listen((content) {
      myNotifies = content;
      if (mounted) {
        setState(() {});
      }
    });
    return StreamProvider<HouseProfileAdj>.value(
        value: DatabaseServiceHouseProfile(house.idHouse).getMyHouseAdj,
        initialData: HouseProfileAdj(
            type: '',
            address: '',
            city: '',
            price: 0.0,
            owner: '',
            idHouse: '',
            description: '',
            numBath: 0,
            numPlp: 0,
            floorNumber: 0,
            latitude: 0.0,
            longitude: 0.0,
            imageURL1: '',
            imageURL2: '',
            imageURL3: '',
            imageURL4: '',
            startDay: 0,
            startMonth: 0,
            startYear: 0,
            endDay: 0,
            endMonth: 0,
            endYear: 0,
            numberNotifies: 0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('House profile page'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async {
                  _showFiltersPanel();
                },
              ),
              badges.Badge(
                showBadge: (myNotifies != null && myNotifies != 0),
                badgeContent: Text(myNotifies?.toString() ?? ""),
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeStyle: BadgeStyle(padding: EdgeInsets.all(4)),
                onTap: () async {
                  await DatabaseServiceHouseProfile(house.idHouse)
                      .updateNotificationHouseProfileAdj(0);
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationLayout(house: house),
                      ),
                    );
                    setState(() {});
                  }
                },
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () async {
                    await DatabaseServiceHouseProfile(house.idHouse)
                        .updateNotificationHouseProfileAdj(0);
                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationLayout(house: house),
                        ),
                      );
                      setState(() {});
                    }
                  },
                ),
              )
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

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({super.key});

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfileAdj>(context);
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailedHouseProfile(/*houseProfile: house*/),
          Center(
              child: ElevatedButton(
            child: Text('Modifica'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => provaModificaCasa(house: house),
                ),
              );
              setState(() {});
            },
          ))
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
    final house = Provider.of<HouseProfileAdj>(context);
    //restituisce quelli con chat non iniziate
    final retrievedMatch = MatchService(uid: house.idHouse ).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
      if (mounted) {
        setState(() {});
      }
    });
    //restituisce quelli con chat iniziate
    final retrievedStartedChats = ChatService(house.idHouse).getStartedChats;
    retrievedStartedChats.listen((content) {
      chats = content;
      if (mounted) {
        setState(() {});
      }
    });
    //print(chats.toString());
    return Column(
        children: [_buildUserList(house, matches), _buildChatList(house, chats)]);
  }
}

Widget _buildChatList(HouseProfileAdj house, List<Chat>? chats) {
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
                return _buildChatListItem(context, chats[index], house);
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

Widget _buildUserList(HouseProfileAdj house, List<String>? matches) {
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
                  return _buildUserListItem(context, matches[index], house);
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

Widget _buildChatListItem(BuildContext context, Chat chat, HouseProfileAdj house) {
  return StreamBuilder<PersonalProfileAdj>(
      stream: DatabaseService(chat.id).persProfileDataAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final name = snapshot.data?.nameA ?? "";
          final surname = snapshot.data?.surnameA ?? "";
          final idPerson= snapshot.data?.uidA ?? "";
          return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                    await MatchService(uid: house.idHouse, otheruid: idPerson)
                        .resetNotification();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      senderUserID: house.idHouse,
                      receiverUserEmail: name + " " + surname,
                      receiverUserID: idPerson,
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
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
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
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        name + " " + surname,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF14181B),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        chat.lastMsg,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF14181B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      chat.timestamp.toDate().hour.toString()
                      + ":" 
                      + chat.timestamp.toDate().minute.toString()
                      + " " 
                      + chat.timestamp.toDate().day.toString()
                      + "/"
                      +chat.timestamp.toDate().month.toString()
                      + "/"
                      +chat.timestamp.toDate().year.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF14181B),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                   (chat.unreadMsg == 0) 
                   ? Text('') 
                   : Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4B39EF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          chat.unreadMsg.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
                
            ])),),),);
                
        } else {
          return Center(
            child: Text('no chat'),
          );
        }
      });
}

Widget _buildUserListItem(BuildContext context, String idMatch, HouseProfileAdj house) {
  return StreamBuilder<PersonalProfileAdj>(
      stream: DatabaseService(idMatch).persProfileDataAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final name = snapshot.data?.nameA ?? "";
          final surname = snapshot.data?.surnameA ?? "";
          final idPerson = snapshot.data?.uidA ?? "";

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
                        senderUserID: house.idHouse,
                        receiverUserEmail: name + " " + surname,
                        receiverUserID: idPerson,
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
                          name,
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
                          surname,
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