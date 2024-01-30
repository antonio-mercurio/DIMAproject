import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';

class MatchService extends ChangeNotifier {
  final String? uid;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference persProfileCollection =
      FirebaseFirestore.instance.collection('personalProfiles');
  final CollectionReference houseProfileCollection =
      FirebaseFirestore.instance.collection('houseProfiles');

  MatchService({this.uid});

  Future _putMatch(
    String userID,
    String otherUserID,
  ) async {
    await MatchService().createNewMatch(userID, otherUserID);
    await MatchService().createNewMatch(otherUserID, userID);
  }

  Future checkMatch(String senderID, String receiverID,
      List<PreferenceForMatch>? preferencesOther) async {
    final searchedPreference =
        PreferenceForMatch(reciverPreferenceId: senderID, choice: "like");
    if (preferencesOther != null) {
      if (preferencesOther.any((element) =>
          element.choice == searchedPreference.choice &&
          element.reciverPreferenceId ==
              searchedPreference.reciverPreferenceId)) {
        /* there is a match */
        await _putMatch(senderID, receiverID);
        return true;
      }
    }
    return false;
  }

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

  Stream<List<PreferenceForMatch>> get getPreferencesForMatch {
    return _firebaseFirestore
        .collection('preference_room')
        .doc(uid)
        .collection('preference')
        .snapshots()
        .map((_preferenceFromSnapshot));
  }

  /* create a new match */
  Future createNewMatch(String userID, String otherUserID) async {
    //add new message to match
    await _firebaseFirestore
        .collection('match')
        .doc(userID)
        .collection('matched_profiles')
        .doc(otherUserID)
        .set({'user1': userID, 'user2': otherUserID});
  }
  /*retrieve chat */

  List<String> _profileMatchedFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<String>((doc) {
      return doc.reference.id;
    }).toList();
  }

  Stream<List<String>> get getMatchedProfile {
    return FirebaseFirestore.instance
        .collection('match')
        .doc(uid)
        .collection('matched_profiles')
        .snapshots()
        .map((_profileMatchedFromSnapshot));
  }

  /*used in the house profile */
  Stream<QuerySnapshot<Object?>>? getChats(List<String>? matchedProfiles) {
    Query query = persProfileCollection;

    if (matchedProfiles != null) {
      if (matchedProfiles.isNotEmpty) {
        query = query.where(FieldPath.documentId, whereIn: matchedProfiles);
        return query.snapshots();
      }
    } else {
      //else code block
    }
    return null;
  }

  /*used in the personal Profile */
  Stream<QuerySnapshot<Object?>>? getChatsPers(List<String>? matchedProfiles) {
    Query query = houseProfileCollection;

    if (matchedProfiles != null) {
      if (matchedProfiles.isNotEmpty) {
        query = query.where(FieldPath.documentId, whereIn: matchedProfiles);
        return query.snapshots();
      }
    }
    return null;
  }
}
