import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prva/models/message.dart';
import 'package:prva/screens/chat_adj.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference houseProfileCollection =
      FirebaseFirestore.instance.collection('houseProfiles');
  final String? uid;

  ChatService(this.uid);
  //send message
  Future<void> sendMessage(
      String senderID, String receiverID, String message) async {
    //get current user info
    //final String currentUserID = _firebaseAuth.currentUser!.uid;
    final String currentUserID = senderID;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderName: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);
    //construct chat roo id from current user and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");
    //add new message to database
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(senderID)
        .collection('myChats')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(receiverID)
        .collection('myChats')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages from the database
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    //construct chat room id from user ids
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(userID)
        .collection('myChats')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Stream<List<String>> get getChats {
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(uid)
        .collection('myChats')
        .snapshots()
        .map((_chatsFromSnap));
  }

  List<String> _chatsFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map<String>((doc) {
      return doc.reference.id;
    }).toList();
  }

  //used in userHomepage
  Stream<QuerySnapshot<Object?>>? getMyChats(List<String>? startedChatsHouses) {
    Query query = houseProfileCollection;

    if (startedChatsHouses != null) {
      if (startedChatsHouses.isNotEmpty) {
        query = query.where(FieldPath.documentId, whereIn: startedChatsHouses);
        return query.snapshots();
      }
    }
    return null;
  }
}
