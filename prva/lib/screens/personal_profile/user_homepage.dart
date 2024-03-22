
import 'package:flutter/material.dart';
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
import 'package:prva/screens/shared/empty.dart';
import 'package:prva/services/chat/chat_service.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/screens/personal_profile/show_details_personal_profile.dart';
import 'package:prva/screens/shared/constant.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const SearchLayout(),
    const ProfileLayout(),
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
          backgroundColor: backgroundColor,
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: mainColor,
            selectedItemColor: backgroundColor,
            iconSize: MediaQuery.of(context).size.width<widthSize 
            ? MediaQuery.sizeOf(context).height * 0.03
            :  MediaQuery.sizeOf(context).height * 0.032,
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
  final ValueNotifier<int> choice = ValueNotifier<int>(1);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


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
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: mainColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings, color: backgroundColor),
                onPressed: () async {
                  if(MediaQuery.sizeOf(context).width<widthSize){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FormFilterPeopleAdj(),
                      ),
                    );
                  }else{
                   
                     setState(() {
                     choice.value = 1;
                    });
                    _scaffoldKey.currentState?.openEndDrawer();

                  }
                },
              ),
              Align(
                child:
                badges.Badge(
                showBadge: (myNotifies != null && myNotifies != 0),
                badgeContent: Text(myNotifies?.toString() ?? "", style: TextStyle(color: backgroundColor),),
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeStyle: badges.BadgeStyle(padding: const EdgeInsets.all(4), badgeColor: errorColor),
                onTap: () async {
                  await MatchService(uid: user.uid).createNotification(0);
                  if (mounted) {
                    if(MediaQuery.sizeOf(context).width<widthSize){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NotificationPersonLayout(profile: user.uid),
                      ),
                    );
                    }else{
                      setState(() {
                     choice.value = 2;
                    });
                    _scaffoldKey.currentState?.openEndDrawer();
                    }
                  }
                },
                child: IconButton(
                  icon: Icon(Icons.notifications, 
                  size: MediaQuery.sizeOf(context).width<widthSize 
                  ? MediaQuery.sizeOf(context).height * 0.03
                  :  MediaQuery.sizeOf(context).height * 0.032,),
                 color: backgroundColor,
                  onPressed: () async {
                    await MatchService(uid: user.uid).createNotification(0);
                    if (mounted) {
                       if(MediaQuery.sizeOf(context).width<widthSize){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationPersonLayout(profile: user.uid),
                        ),
                      );
                    }else{
                       setState(() {
                     choice.value = 2;
                    });
                    _scaffoldKey.currentState?.openEndDrawer();
                    }
                    }
                  },
                ),
              )
          ),],),
           endDrawer: ValueListenableBuilder<int>(
        valueListenable: choice,
        builder: (context, value, child) {
          return value == 1
              ? Drawer(
                 
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: const FormFilterPeopleAdj(),
                )
              : Drawer(
                 
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: NotificationPersonLayout(profile: user.uid),
                );
        },
      ),
          body: AllHousesList( myProfile: personalProfile,)
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
            backgroundColor: mainColor,),

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
                                      backgroundColor:mainColor,
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
                                            color: backgroundColor,
                                            fontSize: MediaQuery.sizeOf(context).height*0.024,
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
    return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,),

            body:Column(
        children: [
          _buildUserList(user, matches, chats, context), 
          _buildChatList(user, chats, context)]));
  }
}

Widget _buildChatList(Utente user, List<Chat>? chats, BuildContext context) {
  if (chats != null) {
    if(chats.isNotEmpty){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
            child: Text(
              'Chats',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
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
  }else{
     return  const Text("");
  }
  }else {
    return const Text("");
  }
}

Widget _buildUserList(Utente user, List<String>? matches, List<Chat>? chats, BuildContext context) {
  if (matches != null) {
    if(matches.isNotEmpty){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 0, 0),
            child: Text(
              'Match',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: const Color(0xFF57636C),
                fontSize: size16(context),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height*0.24,
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
  }else{
    if(chats!= null){
      if(chats.isNotEmpty){
        return const SizedBox();
      }else{
        return SizedBox(
          height: MediaQuery.sizeOf(context).height*0.74,
          child: const EmptyProfile(shapeOfIcon: Icons.sentiment_dissatisfied_rounded, textToShow: 'You don\'t have any match!',)
        );
      }
    }else{
     return SizedBox(
          height: MediaQuery.sizeOf(context).height*0.74,
          child: const EmptyProfile(shapeOfIcon: Icons.sentiment_dissatisfied_rounded, textToShow: 'You don\'t have any match!',));
    }
  }
  } else{
    if(chats!= null){
      if(chats.isNotEmpty){
        return const SizedBox();
      }else{
        return SizedBox(
          height: MediaQuery.sizeOf(context).height*0.74,
          child: const EmptyProfile(shapeOfIcon: Icons.sentiment_dissatisfied_rounded, textToShow: 'You don\'t have any match!',)
        );
      }
    }else{
      return SizedBox(
          height: MediaQuery.sizeOf(context).height*0.74,
          child:const EmptyProfile(shapeOfIcon: Icons.sentiment_dissatisfied_rounded, textToShow: 'You don\'t have any match!',));
    }
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
                      nameReciver: "$type $city",
                      receiverUserID: idHouse,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height*0.1,
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
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: image != ""
                        ? Image.network(
                            image,
                            width: MediaQuery.sizeOf(context).height*0.05,
                            height: MediaQuery.sizeOf(context).height*0.05,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/userPhoto.jpg',
                            width: MediaQuery.sizeOf(context).height*0.05,
                            height: MediaQuery.sizeOf(context).height*0.05,
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
                        style: TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF14181B),
                          fontWeight: FontWeight.w900,
                          fontSize: size16(context)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size20(context),
                      child: Text(
                        chat.lastMsg,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: size12(context),
                          fontFamily: 'Plus Jakarta Sans',
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
                      style: TextStyle(
                        fontSize: size10(context),
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Plus Jakarta Sans',
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
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          chat.unreadMsg.toString(),
                          style: TextStyle(
                            fontSize: size10(context),
                            color: backgroundColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
                
            ])),),),);
                
        } else {
          return const SizedBox();
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
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
            child: Container(
              width: MediaQuery.sizeOf(context).height*0.16,
              height: MediaQuery.sizeOf(context).height*0.22,
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
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: image != ""
                            ? Image.network(
                                image,
                                width:  MediaQuery.sizeOf(context).height*0.08,
                                height: MediaQuery.sizeOf(context).height*0.08,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/userPhoto.jpg',
                                width:  MediaQuery.sizeOf(context).height*0.08,
                                height: MediaQuery.sizeOf(context).height*0.08,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(
                          city,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
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
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
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
        } else {
          return const SizedBox();
        }
      });
}

