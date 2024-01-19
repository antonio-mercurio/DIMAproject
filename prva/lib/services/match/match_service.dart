import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';

class MatchService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference persProfileCollection =
      FirebaseFirestore.instance.collection('personalProfiles');

  //put preference
  Future putPrefence(String senderID, String receiverID, String choice) async {
    //create a new preference
    Preference newPreference= Preference(
      senderPreferenceId: senderID,
      reciverPreferenceId: receiverID,
      choice: choice
    );
    
    //add new message to database
   await _firebaseFirestore
        .collection('preference_room')
        .doc(senderID)
        .collection('preference')
        .doc(receiverID).set(newPreference.toMap());
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
        reciverPreferenceId: doc.reference.id,
        choice: doc.get('choice')
      );
    }).toList();
  }

  Stream<List<PreferenceForMatch>> getPreferencesForMatch(String userID) {
    return _firebaseFirestore
        .collection('preference_room')
        .doc(userID)
        .collection('preference').snapshots().map((_preferenceFromSnapshot));
  }

  /* create a new match */
  Future<void> createNewMatch(String userID, String otherUserID) async {
    //add new message to match
    await _firebaseFirestore
        .collection('match')
        .doc(userID)
        .collection('matched_profiles')
        .doc(otherUserID);
  }
  /*retrieve personal profile to with home profile can chat */

   List<String> _profileMatchedFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<String>((doc) {
      return doc.reference.id;
    }).toList();
  }

  Stream<List<String>> getMatchedProfile(String id) {
    return FirebaseFirestore.instance
        .collection('match')
        .doc(id)
        .collection('matched_profiles')
        .snapshots()
        .map((_profileMatchedFromSnapshot));
  }

  Stream<QuerySnapshot<Object?>>? getChats(List<String>? matchedProfiles) {
    Query query = persProfileCollection;
   
    if (matchedProfiles!= null) {
      if (matchedProfiles.isNotEmpty) {
        query = query.where(FieldPath.documentId, whereIn: matchedProfiles);
        return query.snapshots();
      }
    }
   return null;
  }

}