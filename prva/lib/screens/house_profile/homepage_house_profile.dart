import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/message.dart';
import 'package:prva/screens/house_profile/form_modify_house.dart';
import 'package:badges/badges.dart' as badges;
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/screens/chat/chat.dart';
import 'package:prva/screens/house_profile/form_house_filter.dart';
import 'package:prva/screens/house_profile/all_profile.dart';
import 'package:prva/screens/house_profile/notification.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/shared/empty.dart';
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

  const HouseProfSel({super.key, required this.house});

  @override
  State<HouseProfSel> createState() => _HouseProfSelState(house: house);
}

class _HouseProfSelState extends State<HouseProfSel> {
  final HouseProfileAdj house;
  _HouseProfSelState({required this.house});

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const SearchLayout(),
    const ProfileLayout(),
    const ChatLayout(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
 // int? myNotifies;
  final ValueNotifier<int> choice = ValueNotifier<int>(1);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfileAdj>(context);
    if (house.idHouse == "") {
      return const Loading();
    }
    return StreamProvider<List<PersonalProfileAdj>>.value(
        value: DatabaseService(house.idHouse).getAllPersonalProfiles(),
        initialData: const [],
        child: Scaffold(
          key: _scaffoldKey,
            appBar: AppBar(
            backgroundColor: mainColor,
            actions: <Widget>[
              IconButton(
                icon:  Icon(Icons.settings, color: backgroundColor),
                onPressed: () async {
                  if(MediaQuery.sizeOf(context).width<widthSize){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          FormHouseFilter(uidHouse: house.idHouse),
                      ),
                    );}else{
                   
                     setState(() {
                     choice.value = 1;
                    });
                    _scaffoldKey.currentState?.openEndDrawer();

                  }
                },
              ),
              Align(
                child: badges.Badge(
                showBadge: (house.numberNotifies != 0),
                badgeContent: Text(house.numberNotifies.toString(), style: TextStyle(color: backgroundColor),),
                position: badges.BadgePosition.topEnd(top: 10, end: 10),
                badgeStyle: BadgeStyle(padding: const EdgeInsets.all(4), badgeColor: errorColor),
                onTap: () async {
                  await DatabaseServiceHouseProfile(house.idHouse)
                      .updateNotificationHouseProfileAdj(0);
                  if (mounted) {
                     if(MediaQuery.sizeOf(context).width<widthSize){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationLayout(house: house),
                      ),
                    );
                  }else{
                      setState(() {
                     choice.value = 2;
                    });
                    _scaffoldKey.currentState?.openEndDrawer();
                    }
                  setState(() {});
                  }
                },
                child: IconButton(
                  icon: Icon(Icons.notifications,
                   size: MediaQuery.sizeOf(context).width<widthSize 
                  ? MediaQuery.sizeOf(context).height * 0.03
                  :  MediaQuery.sizeOf(context).height * 0.032,),
                  color: backgroundColor,
                  onPressed: () async {
                    await DatabaseServiceHouseProfile(house.idHouse)
                        .updateNotificationHouseProfileAdj(0);
                    if (mounted) {
                      if(MediaQuery.sizeOf(context).width<widthSize){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationLayout(house: house),
                        ),
                      );
                    }else{
                      setState(() {
                     choice.value = 2;
                    });
                    _scaffoldKey.currentState?.openEndDrawer();
                    }
                    setState(() {
                      
                    });
                    }
                  },
                ),),
              ),
            ],
          ),

          endDrawer: ValueListenableBuilder<int>(
        valueListenable: choice,
        builder: (context, value, child) {
          return value == 1
              ? Drawer(
                 
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: FormHouseFilter(uidHouse: house.idHouse)
                )
              : Drawer(
                 
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: NotificationLayout(house: house,),
                );
        },
      ),

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
    return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,),

            body:
     Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailedHouseProfile(),
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
                      builder: (context) => ModifyHouseProfile(house: house)
                )
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
    ]),);
  }
}

class ChatLayout extends StatefulWidget {
  const ChatLayout({super.key});

  @override
  State<ChatLayout> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatLayout> {
  final ValueNotifier<String> nameReciverTablet = ValueNotifier<String>('');
  final ValueNotifier<String> idReciverTablet = ValueNotifier<String>('');
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
    return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,),

            body:MediaQuery.of(context).size.width < widthSize
            ? SingleChildScrollView(
              child: Column(
              children: [_buildUserList(house, matches, chats, context), _buildChatList(house, chats, context)]),)
              : Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.49,
                      height: MediaQuery.sizeOf(context).height*0.9,
                      child:SingleChildScrollView(
                        child: Column(
                        children: [_buildUserList(house, matches, chats, context), _buildChatList(house, chats, context)])
                  )),
                ),
                 Expanded(
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.49,
                        height: MediaQuery.sizeOf(context).height*0.9,
                        child: (nameReciverTablet.value!= '' && idReciverTablet.value!= '')
                        ? ChatPage(
                      senderUserID: house.idHouse,
                      nameReciver: nameReciverTablet.value,
                      receiverUserID: idReciverTablet.value,
                    )
                    : const EmptyProfile(shapeOfIcon: Icons.ads_click, textToShow: 'Open a chat!'),
                    ),
                 )
              ]

              )
    );
  }

Widget _buildChatList(HouseProfileAdj house, List<Chat>? chats, BuildContext context) {
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
                return _buildChatListItem(context, chats[index], house);
              },
            ),
          ),
        ],
      ),
    );
    }else{
          return  const Text("");
    }
  } else {
    return  const Text("");
  }
}


Widget _buildUserList(HouseProfileAdj house, List<String>? matches, List<Chat>? chats, BuildContext context) {
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
              color: Color.fromARGB(255, 63, 64, 64),
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
                        if(mounted){
                          if(MediaQuery.sizeOf(context).width<widthSize ){
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
                          }else{        
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
                  height: MediaQuery.sizeOf(context).height*0.1,
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
                        "$name $surname",
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
                        color: errorColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          chat.unreadMsg.toString(),
                          style: TextStyle(
                            fontSize: size10(context),
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
          return const SizedBox();
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
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
            child: Container(
              width: MediaQuery.sizeOf(context).height*0.16,
              height: MediaQuery.sizeOf(context).height*0.22,
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
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                 if(MediaQuery.sizeOf(context).width<widthSize ){
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
                          }else{
                            
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
                          name,
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
                          surname,
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

}

