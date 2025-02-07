import 'package:cloud_firestore/cloud_firestore.dart';

class Msgcontent {
  final String? uid;
  final String? sender;
  final String? content;
  final String? type;
  final Timestamp? addtime;
  final String? isRead;

  Msgcontent({
    this.uid,
    this.sender,
    this.content,
    this.type,
    this.addtime,
    this.isRead,
  });

  factory Msgcontent.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Msgcontent(
      uid: data?['uid'],
      sender: data?['sender'],
      content: data?['content'],
      type: data?['type'],
      addtime: data?['addtime'],
      isRead: data?['isRead'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) 'uid': uid,
      if (sender != null) 'sender': sender,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
      if (addtime != null) 'addtime': addtime,
      if (isRead != null) 'isRead': isRead,
    };
  }
}
