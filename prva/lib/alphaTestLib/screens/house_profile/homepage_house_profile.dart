import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/alphaTestLib/models/message.dart';
import 'package:prva/alphaTestLib/screens/house_profile/form_modify_house.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/screens/chat/chat.dart';
import 'package:prva/alphaTestLib/screens/house_profile/form_house_filter.dart';
import 'package:prva/alphaTestLib/screens/house_profile/all_profile.dart';
import 'package:prva/alphaTestLib/screens/house_profile/notification.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';
import 'package:prva/alphaTestLib/screens/shared/empty.dart';

import 'package:prva/alphaTestLib/screens/shared/loading.dart';
import 'package:prva/alphaTestLib/screens/house_profile/show_detailed_profile.dart';

//When we have the list of our "house profile", when clicking on one of them show this home page
//in this home page we have the search option, which show all the people that are looking for an house
//Chat panel will show chats
//Profile panel will show your profile

class HouseProfSel extends StatefulWidget {
  final HouseProfileAdj house;
  final bool tablet;

  HouseProfSel({super.key, required this.house, required this.tablet});

  @override
  State<HouseProfSel> createState() =>
      _HouseProfSelState(house: house, tablet: tablet);
}

class _HouseProfSelState extends State<HouseProfSel> {
  final HouseProfileAdj house;
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
  _HouseProfSelState({required this.house, required this.tablet});

  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions = <Widget>[
    SearchLayout(tablet: tablet, house: house),
    ProfileLayout(tablet: tablet, house: house),
    ChatLayout(
        tablet: tablet, startedChats: startedChats, matched: [], house: house),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
  final HouseProfileAdj house;

  final bool tablet;

  const SearchLayout({super.key, required this.tablet, required this.house});

  @override
  State<SearchLayout> createState() =>
      _SearchLayoutState(tablet: tablet, house: house);
}

class _SearchLayoutState extends State<SearchLayout> {
  // int? myNotifies;
  final bool tablet;
  final HouseProfileAdj house;

  _SearchLayoutState({required this.tablet, required this.house});

  final ValueNotifier<int> choice = ValueNotifier<int>(1);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if (house.idHouse == "") {
      return const Loading();
    }
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FormHouseFilter(uidHouse: house.idHouse),
                    ),
                  );
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
                showBadge: (house.numberNotifies != 0),
                badgeContent: Text(
                  house.numberNotifies.toString(),
                  style: GoogleFonts.plusJakartaSans(color: backgroundColor),
                ),
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeStyle: BadgeStyle(
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
                    //await DatabaseServiceHouseProfile(house.idHouse).updateNotificationHouseProfileAdj(0);
                    if (mounted) {
                      if (!tablet) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NotificationLayout(house: house),
                          ),
                        );
                      } else {
                        setState(() {
                          choice.value = 2;
                        });
                        _scaffoldKey.currentState?.openEndDrawer();
                      }
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
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
                    child: FormHouseFilter(uidHouse: house.idHouse))
                : Drawer(
                    key: Key('notifiesDrawer'),
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: NotificationLayout(
                      house: house,
                    ),
                  );
          },
        ),
        body: AllProfilesList(
          key: Key('body'),
          house: house,
          tablet: tablet,
        ));
  }
}

class ProfileLayout extends StatefulWidget {
  final HouseProfileAdj house;

  final bool tablet;

  const ProfileLayout({super.key, required this.tablet, required this.house});

  @override
  State<ProfileLayout> createState() =>
      _ProfileLayoutState(tablet: tablet, house: house);
}

class _ProfileLayoutState extends State<ProfileLayout> {
  final HouseProfileAdj house;

  final bool tablet;
  _ProfileLayoutState({required this.tablet, required this.house});
  @override
  Widget build(BuildContext context) {
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
            const DetailedHouseProfile(key: Key('detailedProfile')),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ModifyHouseProfile(house: house)));
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
      ]),
    );
  }
}

class ChatLayout extends StatefulWidget {
  final HouseProfileAdj house;
  final bool tablet;
  final List<Chat> startedChats;
  final List<String> matched;
  ChatLayout(
      {super.key,
      required this.tablet,
      required this.startedChats,
      required this.matched,
      required this.house});
  @override
  State<ChatLayout> createState() => _ChatLayoutState(
      tablet: tablet, chats: startedChats, matches: matched, house: house);
}

class _ChatLayoutState extends State<ChatLayout> {
  final HouseProfileAdj house;

  final bool tablet;
  final List<Chat> chats;
  final List<String> matches;
  _ChatLayoutState(
      {required this.tablet,
      required this.chats,
      required this.matches,
      required this.house});
  final ValueNotifier<String> nameReciverTablet = ValueNotifier<String>('');
  final ValueNotifier<String> idReciverTablet = ValueNotifier<String>('');
  //List<String>? matches;
  @override
  Widget build(BuildContext context) {
    //restituisce quelli con chat non iniziate
    /*final retrievedMatch = MatchService(uid: house.idHouse).getMatchedProfile;

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
    });*/
    return Scaffold(
        key: Key('chatLayout'),
        appBar: AppBar(
          backgroundColor: mainColor,
        ),
        body: !tablet
            ? SingleChildScrollView(
                key: Key('phoneChatView'),
                child: Column(children: [
                  _buildUserList(house, matches, chats, context, tablet),
                  _buildChatList(house, chats, context, tablet)
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
                            _buildUserList(
                                house, matches, chats, context, tablet),
                            _buildChatList(house, chats, context, tablet)
                          ]))),
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.49,
                    height: MediaQuery.sizeOf(context).height * 0.9,
                    child: (nameReciverTablet.value != '' &&
                            idReciverTablet.value != '')
                        ? ChatPage(
                            senderUserID: house.idHouse,
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

  Widget _buildChatList(HouseProfileAdj house, List<Chat>? chats,
      BuildContext context, bool tablet) {
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
                    return _buildChatListItem(
                        context, chats[index], house, tablet);
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

  Widget _buildUserList(HouseProfileAdj house, List<String>? matches,
      List<Chat>? chats, BuildContext context, bool tablet) {
    /*if (matches != null)*/ {
      if (matches!.isNotEmpty) {
        return SingleChildScrollView(
          key: Key('horScrollable'),
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
                  color: Color.fromARGB(255, 63, 64, 64),
                ),
                child: ListView.builder(
                    key: Key('matchBuilder'),
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      return _buildUserListItem(
                          context, matches[index], house, tablet);
                    }),
              ),
            ],
          ),
        );
      } else {
        /*if (chats != null) */ {
          if (chats!.isNotEmpty) {
            return const SizedBox(key: Key('chatsUnderMatches'));
          } else {
            return SizedBox(
                key: Key('emptyMatchBanner'),
                height: MediaQuery.sizeOf(context).height * 0.74,
                child: const EmptyProfile(
                  shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
                  textToShow: 'You don\'t have any match!',
                ));
          }
        } /*else {
          return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.74,
              child: const EmptyProfile(
                shapeOfIcon: Icons.sentiment_dissatisfied_rounded,
                textToShow: 'You don\'t have any match!',
              ));
        }*/
      }
    } /*else {
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
    }*/
  }

  Widget _buildChatListItem(
      BuildContext context, Chat chat, HouseProfileAdj house, bool tablet) {
    final image = Icon(Icons.abc);
    final name = "testName";
    final surname = "testName";
    final idPerson = "idtest";

    return InkWell(
      key: Key('chatsInkWell'),
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        {
          if (!tablet) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  senderUserID: house.idHouse,
                  nameReciver: "$name $surname",
                  receiverUserID: idPerson,
                ),
              ),
            );
          } else {
            setState(() {
              nameReciverTablet.value = "$name $surname";
              idReciverTablet.value = idPerson;
            });
          }
        }
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
        child: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.1,
          decoration: BoxDecoration(
            color: Colors.white,
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
                      borderRadius: BorderRadius.circular(26), child: image),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "$name $surname",
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
                                    color: Colors.white,
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

  Widget _buildUserListItem(BuildContext context, String idMatch,
      HouseProfileAdj house, bool tablet) {
    final image = Icon(Icons.abc);
    final name = "testName";
    final surname = "testName";
    final idPerson = "idtest";

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      child: Container(
        width: MediaQuery.sizeOf(context).height * 0.16,
        height: MediaQuery.sizeOf(context).height * 0.22,
        decoration: BoxDecoration(
          color: Colors.white,
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
          key: Key('matchesInkWell'),
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (!tablet) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    senderUserID: house.idHouse,
                    nameReciver: "$name $surname",
                    receiverUserID: idPerson,
                  ),
                ),
              );
            } else {
              setState(() {
                nameReciverTablet.value = "$name $surname";
                idReciverTablet.value = idPerson;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(child: image),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text(
                    name,
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
                    surname,
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
}
