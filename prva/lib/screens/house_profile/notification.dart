import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/shared/loading.dart';

class NotificationLayout extends StatefulWidget {
  final HouseProfileAdj house;
  const NotificationLayout({super.key, required this.house});

  @override
  State<NotificationLayout> createState() =>
      _NotificationLayoutState(house: house);
}

class _NotificationLayoutState extends State<NotificationLayout> {
  List<String>? idmatches;
  final HouseProfileAdj house;
  _NotificationLayoutState({required this.house});
  @override
  Widget build(BuildContext context) {
    final retrievedMatch = MatchService(uid: house.idHouse).getMatchedProfile;

    retrievedMatch.listen((content) {
      idmatches = content;
      if (mounted) {
        setState(() {});
      }
    });
    return Scaffold(body: _buildNotificationList(context, house, idmatches));
  }
}

Widget _buildNotificationList(
    BuildContext context, HouseProfileAdj house, List<String>? idmatches) {
  return StreamBuilder<QuerySnapshot>(
    stream: MatchService().getChats(idmatches),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('error');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        //return Loading();
      }
      if (snapshot.hasData) {
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(context, doc, house))
              .toList(),
        );
      } else {
        return Center(
          child: Text("Non hai ancora notifiche"),
        );
      }
    },
  );
}

Widget _buildUserListItem(
    BuildContext context, DocumentSnapshot document, HouseProfileAdj house) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  return StreamBuilder<MatchPeople>(
      stream:
          MatchService(uid: house.idHouse, otheruid: document.id).getMatches,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.blue,
                        ),
                        title: Text(data['name'] + " " + data['surname'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Row(children: [
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .day
                                  .toString()) ??
                              ""),
                          Text('/'),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .month
                                  .toString()) ??
                              ""),
                          Text('/'),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .year
                                  .toString()) ??
                              ""),
                          Text('-'),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .hour
                                  .toString()) ??
                              ""),
                          Text(":"),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .minute
                                  .toString()) ??
                              "")
                        ]),
                      )
                    ],
                  )));
        } else
          return Text('no');
      });
}
