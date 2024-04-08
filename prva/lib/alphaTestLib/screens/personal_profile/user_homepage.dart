import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/alphaTestLib/models/filters.dart';
import 'package:prva/alphaTestLib/models/message.dart';
import 'package:prva/alphaTestLib/models/personalProfile.dart';
import 'package:prva/alphaTestLib/models/user.dart';
import 'package:prva/alphaTestLib/screens/chat/chat.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/all_houses.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/form_filter_people_adj.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/modify_personal_profile.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/notificationPerson.dart';
import 'package:prva/alphaTestLib/screens/personal_profile/show_details_personal_profile.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prva/alphaTestLib/screens/shared/empty.dart';
import 'package:prva/services/chat/chat_service.dart';

class UserHomepage extends StatefulWidget {
  final bool tablet;

  const UserHomepage({super.key, required this.tablet});

  @override
  State<UserHomepage> createState() => _UserHomepageState(tablet: tablet);
}

class _UserHomepageState extends State<UserHomepage> {
  final bool tablet;
  List<Chat> startedChats = [
    Chat(
        id: 'id',
        lastMsg: 'lastMsg',
        timestamp: Timestamp(10, 5),
        unreadMsg: 1),
    Chat(
        id: 'id2',
        lastMsg: 'lastTest',
        timestamp: Timestamp(16, 7),
        unreadMsg: 3)
  ];
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
    SearchLayout(tablet: tablet),
    ProfileLayout(tablet: tablet),
    ChatLayout(tablet: tablet, startedChats: startedChats),
  ];

  _UserHomepageState({required this.tablet});
  void _onItemTapped(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Utente(uid: 'testUser');

    return Scaffold(
      backgroundColor: backgroundColor,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mainColor,
        selectedItemColor: backgroundColor,
        iconSize: !tablet
            ? MediaQuery.sizeOf(context).height * 0.03
            : MediaQuery.sizeOf(context).height * 0.032,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(key: Key('search'), Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(key: Key('profile'), Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(key: Key('chat'), Icons.chat),
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
  final bool tablet;

  const SearchLayout({super.key, required this.tablet});

  @override
  State<SearchLayout> createState() => _SearchLayoutState(tablet: tablet);
}

class _SearchLayoutState extends State<SearchLayout> {
  final bool tablet;

  FiltersHouseAdj? filtri;
  List<String>? alreadySeenProfiles;
  int? myNotifies = 1;
  final ValueNotifier<int> choice = ValueNotifier<int>(1);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _SearchLayoutState({required this.tablet});
  @override
  Widget build(BuildContext context) {
    final user = Utente(uid: 'testUser');
    PersonalProfileAdj personalProfile = PersonalProfileAdj(
        day: 01,
        month: 01,
        year: 1970,
        uidA: "userTest",
        nameA: "Testname",
        surnameA: "Testsurname",
        description: "descTest",
        gender: "male",
        employment: "student",
        imageURL1: "t",
        imageURL2: "e",
        imageURL3: "s",
        imageURL4: "t");

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: mainColor,
          actions: <Widget>[
            IconButton(
              key: Key('settings'),
              icon: Icon(Icons.settings, color: backgroundColor),
              onPressed: () async {
                if (!tablet) {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormFilterPeopleAdj(),
                    ),
                  );*/
                } else {
                  setState(() {
                    choice.value = 1;
                  });
                  _scaffoldKey.currentState?.openEndDrawer();
                }
              },
            ),
            Align(
                child: badges.Badge(
              key: Key('notifiesBadge'),
              showBadge: (myNotifies != null && myNotifies != 0),
              badgeContent: Text(
                myNotifies?.toString() ?? "",
                style: GoogleFonts.plusJakartaSans(color: backgroundColor),
              ),
              position: badges.BadgePosition.topEnd(top: 10, end: 10),
              badgeStyle: badges.BadgeStyle(
                  padding: const EdgeInsets.all(4), badgeColor: errorColor),
              child: IconButton(
                key: Key('notifiesIcon'),
                icon: Icon(
                  Icons.notifications,
                  size: !tablet
                      ? MediaQuery.sizeOf(context).height * 0.03
                      : MediaQuery.sizeOf(context).height * 0.032,
                ),
                color: backgroundColor,
                onPressed: () async {
                  myNotifies = 0;
                  //await MatchService(uid: user.uid).createNotification(0);
                  if (mounted) {
                    if (!tablet) {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationPersonLayout(profile: user.uid),
                        ),
                      );*/
                    } else {
                      setState(() {
                        choice.value = 2;
                      });
                      _scaffoldKey.currentState?.openEndDrawer();
                    }
                  }
                },
              ),
            )),
          ],
        ),
        endDrawer: ValueListenableBuilder<int>(
          key: Key('drawerBuilder'),
          valueListenable: choice,
          builder: (context, value, child) {
            return value == 1
                ? Drawer(
                    key: Key('formDrawer'),
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: const FormFilterPeopleAdj(),
                  )
                : Drawer(
                    key: Key('notifiesDrawer'),
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: NotificationPersonLayout(),
                  );
          },
        ),
        body: AllHousesList(
            key: Key('body'), tablet: true, myProfile: personalProfile));
  }
}

class ProfileLayout extends StatelessWidget {
  final bool tablet;

  const ProfileLayout({super.key, required this.tablet});

  @override
  Widget build(BuildContext context) {
    final personalData = PersonalProfileAdj(
        day: 01,
        month: 01,
        year: 1970,
        uidA: "userTest",
        nameA: "Testname",
        surnameA: "Testsurname",
        description: "descTest",
        gender: "male",
        employment: "student",
        imageURL1: "t",
        imageURL2: "e",
        imageURL3: "s",
        imageURL4: "t");
    return Scaffold(
        key: Key('profileLayout'),
        appBar: AppBar(
          backgroundColor: mainColor,
        ),
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DetailedPersonalProfile(key: Key('detailedProfile')),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: ElevatedButton(
                    key: Key('modifyButton'),
                    onPressed: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModificaPersonalProfile(
                                  personalProfile: personalData,
                                )),
                      );*/
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
                    child: Text(
                      'Modify your profile!',
                      style: GoogleFonts.plusJakartaSans(
                        color: backgroundColor,
                        fontSize: MediaQuery.sizeOf(context).height * 0.024,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )))
        ]));
  }
}

class ChatLayout extends StatefulWidget {
  final bool tablet;
  final List<Chat> startedChats;

  ChatLayout({super.key, required this.tablet, required this.startedChats});

  @override
  State<ChatLayout> createState() =>
      _ChatLayoutState(tablet: tablet, startedChats: startedChats);
}

class _ChatLayoutState extends State<ChatLayout> {
  final bool tablet;
  final List<Chat> startedChats;

  final ValueNotifier<String> nameReciverTablet = ValueNotifier<String>('');
  final ValueNotifier<String> idReciverTablet = ValueNotifier<String>('');
  List<String>? matches;
  late List<Chat>? chats = startedChats;

  _ChatLayoutState({required this.tablet, required this.startedChats});
  @override
  Widget build(BuildContext context) {
    final user = Utente(uid: 'testUser');
    //restituisce quelli con chat non iniziate
    /*final retrievedMatch = MatchService(uid: user.uid).getMatchedProfile;

    retrievedMatch.listen((content) {
      matches = content;
      if (mounted) {
        setState(() {});
      }
    });*/
    //restituisce quelli con chat iniziate

    return Scaffold(
        key: Key('chatLayout'),
        appBar: AppBar(
          backgroundColor: mainColor,
        ),
        body: !tablet
            ? SingleChildScrollView(
                child: Column(key: Key('phoneChatView'), children: [
                  _buildUserList(user, matches, chats, context),
                  _buildChatList(user, chats, context)
                ]),
              )
            : Row(key: Key('tabletChatView'), children: <Widget>[
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.49,
                    height: MediaQuery.sizeOf(context).height * 0.9,
                    child: SingleChildScrollView(
                        key: Key('tabletScrollable'),
                        child: Column(children: [
                          _buildUserList(user, matches, chats, context),
                          _buildChatList(user, chats, context)
                        ])),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.49,
                    height: MediaQuery.sizeOf(context).height * 0.9,
                    child: startedChats.isNotEmpty
                        ? ChatPage(
                            senderUserID: user.uid,
                            nameReciver: nameReciverTablet.value,
                            receiverUserID: idReciverTablet.value,
                          )
                        : const EmptyProfile(
                            shapeOfIcon: Icons.ads_click,
                            textToShow: 'Open a chat!'),
                  ),
                )
              ]));
  }

  Widget _buildChatList(Utente user, List<Chat>? chats, BuildContext context) {
    if (chats != null) {
      if (chats.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Text(
                  'Chats',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF57636C),
                    fontSize: size16(context),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 44),
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
        return const Text("");
      }
    } else {
      return const Text("");
    }
  }

  Widget _buildUserList(Utente user, List<String>? matches, List<Chat>? chats,
      BuildContext context) {
    if (matches != null) {
      if (matches.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 0, 0),
                child: Text(
                  'Match',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF57636C),
                    fontSize: size16(context),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.24,
                decoration: const BoxDecoration(
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
        if (chats != null) {
          if (chats.isNotEmpty) {
            return const SizedBox();
          } else {
            return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.74,
                child: const EmptyProfile(
                  shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
                  textToShow: 'You don\'t have any match!',
                ));
          }
        } else {
          return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.74,
              child: const EmptyProfile(
                shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
                textToShow: 'You don\'t have any match!',
              ));
        }
      }
    } else {
      if (chats != null) {
        if (chats.isNotEmpty) {
          return const SizedBox();
        } else {
          return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.74,
              child: const EmptyProfile(
                shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
                textToShow: 'You don\'t have any match!',
              ));
        }
      } else {
        return SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.74,
            child: const EmptyProfile(
              shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
              textToShow: 'You don\'t have any match!',
            ));
      }
    }
  }

  Widget _buildChatListItem(BuildContext context, Chat chat, Utente user) {
    final image = Icon(Icons.abc);
    final type = "Apartment";
    final city = "Milan";
    final idHouse = "houseTest";
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        /*
                await MatchService(uid: user.uid, otheruid: idHouse)
                    .resetNotification();
                if (mounted) {
                  if (MediaQuery.sizeOf(context).width < widthSize) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          senderUserID: user.uid,
                          nameReciver: "$type $city",
                          receiverUserID: idHouse,
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      nameReciverTablet.value = "$type $city";
                      idReciverTablet.value = idHouse;
                    });
                  }
                }*/
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.1,
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: const [
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
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: image != ""
                        ? Icon(Icons.abc)
                        : Image.asset(
                            'assets/userPhoto.jpg',
                            width: MediaQuery.sizeOf(context).height * 0.05,
                            height: MediaQuery.sizeOf(context).height * 0.05,
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
                          "$type $city",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                              letterSpacing: 0.2,
                              wordSpacing: 1.5,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w900,
                              fontSize: size16(context)),
                        ),
                      ),
                      SizedBox(
                        height: size20(context),
                        child: Text(
                          chat.lastMsg,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: size12(context),
                            color: const Color(0xFF14181B),
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
                        "${chat.timestamp.toDate().hour}:${chat.timestamp.toDate().minute} ${chat.timestamp.toDate().day}/${chat.timestamp.toDate().month}/${chat.timestamp.toDate().year}",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: size10(context),
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF14181B),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      (chat.unreadMsg == 0)
                          ? const Text('')
                          : Container(
                              width: size18(context),
                              height: size18(context),
                              decoration: BoxDecoration(
                                color: errorColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  chat.unreadMsg.toString(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: size10(context),
                                    color: backgroundColor,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}

Widget _buildUserListItem(BuildContext context, String idMatch, Utente user) {
  final image = Icon(Icons.abc);
  final type = "Apartment";
  final city = "Rome";
  final idHouse = "houseTest";

  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
    child: Container(
      width: MediaQuery.sizeOf(context).height * 0.16,
      height: MediaQuery.sizeOf(context).height * 0.22,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: const [
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
          /*
                    if (MediaQuery.sizeOf(context).width < widthSize) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            senderUserID: user.uid,
                            nameReciver: "$type $city",
                            receiverUserID: idHouse,
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        nameReciverTablet.value = "$type $city";
                        idReciverTablet.value = idHouse;
                      });
                    }*/
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                child: image != ""
                    ? image
                    : Image.asset(
                        'assets/userPhoto.jpg',
                        width: MediaQuery.sizeOf(context).height * 0.08,
                        height: MediaQuery.sizeOf(context).height * 0.08,
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  city,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF14181B),
                    fontSize: size12(context),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF14181B),
                    fontSize: size12(context),
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
}
