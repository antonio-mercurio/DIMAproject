import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderName;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senderID,
      required this.senderName,
      required this.receiverID,
      required this.message,
      required this.timestamp});

  //convert to a map to store in firebase
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderName': senderName,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
 
}
 class Chat {
  final String id;
  final String lastMsg;
  final Timestamp timestamp;
  final int unreadMsg;

  Chat({required this.id, required this.lastMsg, required this.timestamp, required this.unreadMsg});
  
  }