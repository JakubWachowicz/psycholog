import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  final String? messageId;
  final String student_uid;
  final String specialist_uid;
  final String student_name;
  final String specialist_name;
  final String? student_avatar;
  final String? specialist_avatar;
  final String? last_msg;
  final Timestamp? last_time;
  final int? msg_num;
  final String? student_lastMessageSeen;
  final String? specialist_lastMessageSeen;
  final int? unreadMessagesCountStudent;
  final int? unreadMessagesCountSpecialist;
  final String? message_type;

  Msg({
    this.messageId,
    required this.student_uid,
    required this.specialist_uid,
    required this.student_name,
    required this.specialist_name,
    this.student_avatar,
    this.specialist_avatar,
    this.last_msg,
    this.last_time,
    this.msg_num,
    this.student_lastMessageSeen,
    this.specialist_lastMessageSeen,
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
      student_uid: data?['student_uid'],
      specialist_uid: data?['specialist_uid'],
      student_name: data?['student_name'],
      specialist_name: data?['specialist_name'],
      student_avatar: data?['student_avatar'],
      specialist_avatar: data?['specialist_avatar'],
      last_msg: data?['last_msg'],
      last_time: data?['last_time'],
      msg_num: data?['msg_num'],
      student_lastMessageSeen: data?['student_lastMessageSeen'],
      specialist_lastMessageSeen: data?['specialist_lastMessageSeen'],
      unreadMessagesCountStudent: data?['unreadMessagesCountStudent'],
      unreadMessagesCountSpecialist: data?['unreadMessagesCountSpecialist'],
      message_type: data?['message_type'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (messageId != null) "messageId": messageId,
      if (student_uid != null) "student_uid": student_uid,
      if (specialist_uid != null) "specialist_uid": specialist_uid,
      if (student_name != null) "student_name": student_name,
      if (specialist_name != null) "specialist_name": specialist_name,
      if (student_avatar != null) "student_avatar": student_avatar,
      if (specialist_avatar != null) "specialist_avatar": specialist_avatar,
      if (last_msg != null) "last_msg": last_msg,
      if (last_time != null) "last_time": last_time,
      if (msg_num != null) "msg_num": msg_num,
      if (student_lastMessageSeen != null) "student_lastMessageSeen": student_lastMessageSeen,
      if (specialist_lastMessageSeen != null) "specialist_lastMessageSeen": specialist_lastMessageSeen,
      if (unreadMessagesCountStudent != null) "unreadMessagesCountStudent": unreadMessagesCountStudent,
      if (unreadMessagesCountSpecialist != null) "unreadMessagesCountSpecialist": unreadMessagesCountSpecialist,
      if (message_type != null) "message_type": message_type,
    };
  }
}
