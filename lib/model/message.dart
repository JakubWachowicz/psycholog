import 'package:cloud_firestore/cloud_firestore.dart';

class Message {


  late String chatId;
  late String senderId;
  late String text;
  late String receiverId;
  late DateTime timestamp;

  Message({
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.receiverId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    "chatId": chatId,
    "senderId": senderId,
    "text": text,
    "receiverId": receiverId,
    "timestamp": timestamp,
  };

  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Message(
      chatId: snapshot['chatId'],
      senderId: snapshot['senderId'],
      text: snapshot['text'],
      receiverId: snapshot['receiverId'],
      timestamp: snapshot['timestamp'],
    );
  }
}