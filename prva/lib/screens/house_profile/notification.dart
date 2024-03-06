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
      body: _buildNotificationList(context, house, idmatches));
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
          padding: EdgeInsets.fromLTRB(
            0,
            8,
            0,
            44,
          ),
          scrollDirection: Axis.vertical,
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

  String calculateTimestamp(Timestamp tmp){
    final difference= Timestamp.now().toDate().difference(tmp.toDate());
    if(difference.inSeconds<60){
      return difference.inSeconds.toString() + ' seconds ago';
    }else if(difference.inMinutes <60){
       return difference.inMinutes.toString() + ' minutes ago';

    }else if(difference.inHours<24){
      return difference.inHours.toString() + ' hours ago';

    }else if(difference.inDays<31){
      return difference.inDays.toString() + ' days ago';
    }else {
      final differenceM = (difference.inDays/31).floor();
      return differenceM.toString() +  ' months ago';

    }
      }

  return StreamBuilder<MatchPeople>(
      stream:
          MatchService(uid: house.idHouse, otheruid: document.id).getMatches,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                              data['imageURL1'],
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
                                  'You have matched with ' + data['name'] + " " + data['surname']+ '! Go to the chat to start a conversation! ',
                                  maxLines: 4,
                                  style: 
                                       const TextStyle(
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
                                child: Text((calculateTimestamp(snapshot.data?.timestamp ?? Timestamp.now())), 
                                style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                                /*
                                
                                Row(children: [
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .day
                                  .toString()) ??
                              "",
                              style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text('/',
                          style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .month
                                  .toString()) ??
                              "",
                              style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text('/',
                          style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .year
                                  .toString()) ??
                              "",
                              style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text('-',
                          style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .hour
                                  .toString()) ??
                              "",
                              style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text(":",
                          style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),),
                          Text((snapshot.data?.timestamp
                                  .toDate()
                                  .minute
                                  .toString()) ??
                              "",
                              style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),)
                        ]),*/
                                  
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
          /* Padding(
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
                  )));*/
        } else {
          return Text('');
        }
      });
}
