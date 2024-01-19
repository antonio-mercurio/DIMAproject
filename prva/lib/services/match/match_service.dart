import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/preference.dart';

class MatchService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //put preference
  Future putPrefence(String senderID, String receiverID, String choice) async {
    //create a new preference
    Preference newPreference = Preference(
        senderPreferenceId: senderID,
        reciverPreferenceId: receiverID,
        choice: choice);

    //add new message to database
    await _firebaseFirestore
        .collection('preference_room')
        .doc(senderID)
        .collection('preference')
        .doc(receiverID)
        .set(newPreference.toMap());
  }

  //get preference from the database
  Stream<QuerySnapshot> getPreferences(String userID) {
    return _firebaseFirestore
        .collection('preference_room')
        .doc(userID)
        .collection('preference')
        .snapshots();
  }

  List<PreferenceForMatch> _preferenceFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<PreferenceForMatch>((doc) {
      return PreferenceForMatch(
          reciverPreferenceId: doc.reference.id, choice: doc.get('choice'));
    }).toList();
  }

  Stream<List<PreferenceForMatch>> getPreferencesForMatch(String userID) {
    return _firebaseFirestore
        .collection('preference_room')
        .doc(userID)
        .collection('preference')
        .snapshots()
        .map((_preferenceFromSnapshot));
  }

  /* create a new match */
  Future<void> createNewMatch(String userID, String otherUserID) async {
    //construct match using the IDs
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    //add new message to database
    await _firebaseFirestore.collection('match').doc(chatRoomID);
  }

  /*retrieve personal profile to with home profile can chat */
}
