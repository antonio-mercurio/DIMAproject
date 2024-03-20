
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/message.dart';
import 'package:prva/screens/personal_profile/modify_personal_profile.dart';
import 'package:prva/screens/personal_profile/form_filter_people_adj.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/personal_profile/notification_person.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prva/screens/personal_profile/all_houses.dart';
import 'package:prva/screens/shared/constant.dart';
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
  static final List<Widget> _widgetOptions = <Widget>[
    const SearchLayout(),
    ProfileLayout(),
    const ChatLayout(),
  ];
  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);

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
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFF4B39EF),
            selectedItemColor: Colors.white,
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
   int? myNotifies;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    final personalProfile = Provider.of<PersonalProfileAdj>(context);
    final retrievedNotifies = MatchService(uid: user.uid).getNotification;
    retrievedNotifies.listen((content) {
      myNotifies = content;
      if (mounted) {
        setState(() {});
      }
    });
    return StreamProvider<List<HouseProfileAdj>>.value(
        value: DatabaseServiceHouseProfile(user.uid).getAllHousesAdj,
        initialData: const [],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF4B39EF),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () async {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FormFilterPeopleAdj(),
                      ),
                    );
                },
              ),
              badges.Badge(
                showBadge: (myNotifies != null && myNotifies != 0),
                badgeContent: Text(myNotifies?.toString() ?? ""),
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeStyle: const badges.BadgeStyle(padding: EdgeInsets.all(4)),
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
                  icon: const Icon(Icons.notifications),
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
          body: AllHousesList(
            myProfile: personalProfile,
          ),
        ));
  }
}

class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final personalData = Provider.of<PersonalProfileAdj>(context);

    return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF4B39EF),),

            body: Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailedPersonalProfile(),
          const SizedBox(
            height: 20,
          ),
          Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                      child:  ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ModificaPersonalProfile(
                            personalProfile: personalData,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(230, 52),
                                      backgroundColor: mainColor,
                                       elevation: 3.0,
                                       shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                       ),
                                       side: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child : Text('Modify your profile!',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                            color: Colors.white,
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                    ),
                                    ),
                                    ),
            ),
          )
        ],
      )))
    ])
  );}
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
    return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF4B39EF),),

            body:Column(
        children: [_buildUserList(user, matches), _buildChatList(user, chats)]));
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
          final idHouse = snapshot.data?.idHouse ?? "";
          return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                    await MatchService(uid: user.uid, otheruid: idHouse)
                        .resetNotification();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      senderUserID: user.uid,
                      receiverUserEmail: type + " " + city,
                      receiverUserID: idHouse,
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
                        type + " " + city,
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

Widget _buildUserListItem(BuildContext context, String idMatch, Utente user) {
  return StreamBuilder<HouseProfileAdj>(
      stream: DatabaseServiceHouseProfile(idMatch).getMyHouseAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final type = snapshot.data?.type ?? "";
          final city = snapshot.data?.city ?? "";
          final idHouse = snapshot.data?.idHouse ?? "";

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
                        receiverUserID: idHouse,
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

