import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/screens/shared/empty.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/match/match_service.dart';

class NotificationLayout extends StatefulWidget {
  final HouseProfileAdj house;
  const NotificationLayout({super.key, required this.house});

  @override
  State<NotificationLayout> createState() =>
      _NotificationLayoutState(house: house);
}

class _NotificationLayoutState extends State<NotificationLayout> {
  List<MatchPeople>? idmatches;
  final HouseProfileAdj house;
  _NotificationLayoutState({required this.house});

  @override
  Widget build(BuildContext context) {
    final retrievedMatch = MatchService(uid: house.idHouse).getMatchWithTmp;

    retrievedMatch.listen((content) {
      idmatches = content;
      if (mounted) {
        setState(() {});
      }
    });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(
            'Notifications',
            style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                            color: backgroundColor,
                                            fontSize: size32(context),
                                            fontWeight: FontWeight.w500,
            ),

          ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: _buildNotificationList(context, house, idmatches));
  }
}

Widget _buildNotificationList(
    BuildContext context, HouseProfileAdj house, List<MatchPeople>? idmatches) {
      if(idmatches!= null && idmatches.isNotEmpty){
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            0,
            8,
            0,
            44,
          ),
          scrollDirection: Axis.vertical,
      itemCount: idmatches.length,
      itemBuilder: (context, index) {
        return _buildUserListItem(context, idmatches[index], house);
      },
    );
      } else {
         return const EmptyProfile(shapeOfIcon: Icons.sentiment_dissatisfied_rounded, textToShow: 'You don\'t have any notifications!',);
      }
    }

Widget _buildUserListItem(
    BuildContext context, MatchPeople idmatch, HouseProfileAdj house) {
  String calculateTimestamp(Timestamp tmp) {
    final difference = Timestamp.now().toDate().difference(tmp.toDate());
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 31) {
      return '${difference.inDays} days ago';
    } else {
      final differenceM = (difference.inDays / 31).floor();
      return '$differenceM months ago';
    }
  }

  return StreamBuilder<PersonalProfileAdj>(
      stream:
          DatabaseService(idmatch.otheUserID).persProfileDataAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final name=  snapshot.data?.nameA ?? "";
          final surname=  snapshot.data?.surnameA ?? "";
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 242, 244),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x33000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color.fromARGB(255, 62, 62, 62),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height*0.1,
                      height: MediaQuery.sizeOf(context).height*0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            image,
                            width: MediaQuery.sizeOf(context).height*0.052,
                            height: MediaQuery.sizeOf(context).height*0.052,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Match!',
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: const Color(0xFF101213),
                                fontSize: size18(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                'You have matched with ' +
                                    name+
                                    " " +
                                    surname +
                                    '! Go to the chat to start a conversation! ',
                                maxLines: 6,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: const Color(0xFF101213),
                                  fontSize: size16(context),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                              child: Text(
                                (calculateTimestamp(idmatch.timestamp)),
                                style:  TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: const Color(0xFF101213),
                                  fontSize: size12(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
         
        } else {
          return const Text('');
        }
      });
}
