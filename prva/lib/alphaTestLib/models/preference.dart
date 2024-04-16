import 'package:cloud_firestore/cloud_firestore.dart';

class MatchPeople {
  final String userID;
  final String otheUserID;
  final Timestamp timestamp;

  MatchPeople(
      {required this.userID,
      required this.otheUserID,
      required this.timestamp});
}
