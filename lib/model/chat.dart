import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  late String id;
  late String firstUserId;
  late String secondUserId ;

  Chat({
    required this.id,
    required this.firstUserId,
    required this.secondUserId,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "senderId": firstUserId,
    "receiverId":secondUserId,
  };

  static Chat fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;


    return Chat(
      id: snapshot['id'],
      firstUserId: snapshot['firstUserId'],
      secondUserId: snapshot['secondUserId'],
    );
  }
}
