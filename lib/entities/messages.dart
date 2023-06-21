import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  final String? messageId;
  final String? from_uid;
  final String? to_uid;
  final String? from_name;
  final String? to_name;
  final String? from_avatar;
  final String? to_avatar;
  final String? last_msg;
  final Timestamp? last_time;
  final int? msg_num;
  final String? from_lastMessageSeen;
  final String? to_lastMessageSeen;
  final int? unreadMessagesCountStudent;
  final int? unreadMessagesCountSpecialist;
  final String? message_type; // New field: message_type

  Msg({
    this.messageId,
    this.from_uid,
    this.to_uid,
    this.from_name,
    this.to_name,
    this.from_avatar,
    this.to_avatar,
    this.last_msg,
    this.last_time,
    this.msg_num,
    this.from_lastMessageSeen,
    this.to_lastMessageSeen,
    this.unreadMessagesCountStudent,
    this.unreadMessagesCountSpecialist,
    this.message_type,
  });

  factory Msg.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Msg(
      messageId: snapshot.id,
      from_uid: data?['from_uid'],
      to_uid: data?['to_uid'],
      from_name: data?['from_name'],
      to_name: data?['to_name'],
      from_avatar: data?['from_avatar'],
      to_avatar: data?['to_avatar'],
      last_msg: data?['last_msg'],
      last_time: data?['last_time'],
      msg_num: data?['msg_num'],
      from_lastMessageSeen: data?['from_lastMessageSeen'],
      to_lastMessageSeen: data?['to_lastMessageSeen'],
      unreadMessagesCountStudent: data?['unreadMessagesCountStudent'],
      unreadMessagesCountSpecialist: data?['unreadMessagesCountSpecialist'],
      message_type: data?['message_type'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (messageId != null) "messageId": messageId,
      if (from_uid != null) "from_uid": from_uid,
      if (to_uid != null) "to_uid": to_uid,
      if (from_name != null) "from_name": from_name,
      if (to_name != null) "to_name": to_name,
      if (from_avatar != null) "from_avatar": from_avatar,
      if (to_avatar != null) "to_avatar": to_avatar,
      if (last_msg != null) "last_msg": last_msg,
      if (last_time != null) "last_time": last_time,
      if (msg_num != null) "msg_num": msg_num,
      if (from_lastMessageSeen != null) "from_lastMessageSeen": from_lastMessageSeen,
      if (to_lastMessageSeen != null) "to_lastMessageSeen": to_lastMessageSeen,
      if (unreadMessagesCountStudent != null) "unreadMessagesCountStudent": unreadMessagesCountStudent,
      if (unreadMessagesCountSpecialist != null) "unreadMessagesCountSpecialist": unreadMessagesCountSpecialist,
      if (message_type != null) "message_type": message_type,
    };
  }
}
