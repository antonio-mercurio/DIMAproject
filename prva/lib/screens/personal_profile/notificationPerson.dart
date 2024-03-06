import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';

class NotificationPersonLayout extends StatefulWidget {
  final String profile;
  const NotificationPersonLayout({super.key, required this.profile});

  @override
  State<NotificationPersonLayout> createState() =>
      _NotificationPersonLayoutState(profile: profile);
}

class _NotificationPersonLayoutState extends State<NotificationPersonLayout> {
  List<MatchPeople>? idmatches;
  final String profile;
  _NotificationPersonLayoutState({required this.profile});
  @override
  Widget build(BuildContext context) {
    final retrievedMatch = MatchService(uid: profile).getMatchWithTmp;

    retrievedMatch.listen((content) {
      idmatches = content;
      if (mounted) {
        setState(() {});
      }
    });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Notifications',
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: _buildNotificationList(context, profile, idmatches));
  }
}

Widget _buildNotificationList(
    BuildContext context, String profile, List<MatchPeople>? idmatches) {
    if(idmatches!= null){
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(
            0,
            8,
            0,
            44,
          ),
          scrollDirection: Axis.vertical,
      itemCount: idmatches.length,
      itemBuilder: (context, index) {
        return _buildUserListItem(context, idmatches[index], profile);
      },
    );
      } else {
        return Center(
          child: Text("Non hai ancora notifiche"),
        );
      }
    }

Widget _buildUserListItem(
    BuildContext context, MatchPeople idmatch, String profile) {
  String calculateTimestamp(Timestamp tmp) {
    final difference = Timestamp.now().toDate().difference(tmp.toDate());
    if (difference.inSeconds < 60) {
      return difference.inSeconds.toString() + ' seconds ago';
    } else if (difference.inMinutes < 60) {
      return difference.inMinutes.toString() + ' minutes ago';
    } else if (difference.inHours < 24) {
      return difference.inHours.toString() + ' hours ago';
    } else if (difference.inDays < 31) {
      return difference.inDays.toString() + ' days ago';
    } else {
      final differenceM = (difference.inDays / 31).floor();
      return differenceM.toString() + ' months ago';
    }
  }

  return StreamBuilder<HouseProfileAdj>(
      stream:
          DatabaseServiceHouseProfile(idmatch.otheUserID).getMyHouseAdj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data?.imageURL1 ?? "";
          final type=  snapshot.data?.type ?? "";
          final city=  snapshot.data?.city ?? "";
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 242, 244),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x33000000),
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color.fromARGB(255, 62, 62, 62),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Image.network(
                            image,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Match!',
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF101213),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                              child: Text(
                                'You have matched with ' +
                                    type+
                                    " " +
                                    city +
                                    '! Go to the chat to start a conversation! ',
                                maxLines: 4,
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                              child: Text(
                                (calculateTimestamp(idmatch.timestamp)),
                                style: const TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 12,
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
          return Text('342 not.dart');
        }
      });
}
