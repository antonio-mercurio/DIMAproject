import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/services/match/match_service.dart';



class NotificationLayout extends StatefulWidget {
  const NotificationLayout({super.key});

  @override
  State<NotificationLayout> createState() => _NotificationLayoutState();
}

class _NotificationLayoutState extends State<NotificationLayout> {
  List<String>? idmatches;

  @override
  Widget build(BuildContext context) {
    final house = Provider.of<HouseProfileAdj>(context);
    final retrievedMatch = MatchService(uid: house.idHouse).getMatchedProfile;

    retrievedMatch.listen((content) {
      idmatches = content;
      if (mounted) {
        setState(() {});
      }
    });
    return _buildNotificationList(context, house, idmatches);
}
}

Widget _buildNotificationList( BuildContext context, HouseProfileAdj house, List<String>? idmatches) {
  return StreamBuilder<QuerySnapshot>(
    stream: MatchService().getChats(idmatches),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('error');
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

  return Scaffold(
    body: StreamBuilder<MatchPeople>(
            stream: MatchService(uid: house.idHouse,otheruid: document.id).getMatches,
            builder: (context, snapshot) {
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
                subtitle: Text(snapshot.data!.timestamp.toString()),
              ),   
            ],
          )
          )
          );
            }
          ));
}

