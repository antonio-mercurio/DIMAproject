import 'package:cloud_firestore/cloud_firestore.dart';

class Preference {
  final String senderPreferenceId;
  final String reciverPreferenceId;
  final String choice;

  Preference(
      {required this.senderPreferenceId,
      required this.reciverPreferenceId,
      required this.choice});

  //convert to a map to store in firebase
  Map<String, dynamic> toMap() {
    return {
      'senderPreferenceID': senderPreferenceId,
      'receiverPrefernceID': reciverPreferenceId,
      'choice': choice,
    };
  }
}


class PreferenceForMatch {
  final String reciverPreferenceId;
  final String choice;

  

  PreferenceForMatch({required this.reciverPreferenceId, required this.choice});
}


class MatchPeople{
  final String userID;
  final String otheUserID;
  final Timestamp timestamp;

  MatchPeople({required this.userID, required this.otheUserID, required this.timestamp});
}
