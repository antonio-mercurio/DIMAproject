import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final String lastMsg;
  final Timestamp timestamp;
  final int unreadMsg;

  Chat(
      {required this.id,
      required this.lastMsg,
      required this.timestamp,
      required this.unreadMsg});
}
