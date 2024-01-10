import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/entities/msg_content.dart';

import '../entities/messages.dart';
import '../entities/report.dart';

class SendMessageController {
  late String uid;
  late String to_uid;
  late String doc_id;
  late bool isItStudent;
  late DocumentReference messagesDocRef;

  SendMessageController(this.doc_id, this.uid, this.to_uid, this.isItStudent,
      {required this.messagesDocRef});



  Stream<DocumentSnapshot<Msg>>  getChatInformation(){
    return messagesDocRef.withConverter(
    fromFirestore: Msg.fromFirestore,
    toFirestore: (Msg msg, options) => msg.toFirestore()).snapshots();
  }




 read() async {
   if(isItStudent){

     if(Get.currentRoute.contains(AppRoutes.Chat) || Get.currentRoute.contains(AppRoutes.SpecialistReportChat)){
       await messagesDocRef.update({

         "unreadMessagesCountStudent": 0,

       });
     }

   }
   else{

     if(Get.currentRoute.contains(AppRoutes.SpecialistChat) || Get.currentRoute.contains(AppRoutes.SpecialistReportChat)){
       await messagesDocRef.update({

         "unreadMessagesCountSpecialist":  0,

       });
     }

   }
 }
  getMessageList() async {

    return await messagesDocRef
        .collection("msglist")
        .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msgcontent, options) =>
          msgcontent.toFirestore(),
    ).orderBy("addtime", descending: false);
  }

  sendMessage(String message, String senderName) async {
    if (message.trim() == "") return;
    String sendContent = message.trim();
    final content = Msgcontent(
      sender: senderName,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
      uid: uid,
      isRead: "False",
    );

    await messagesDocRef
        .collection("msglist")
        .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msgcontent, options) =>
          msgcontent.toFirestore(),
    )
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id ${doc.id}");
    });


    if(isItStudent){
      await messagesDocRef.update({
        "last_msg": sendContent,
        "last_time": Timestamp.now(),
        "unreadMessagesCountStudent": 0,
        "unreadMessagesCountSpecialist":  FieldValue.increment(1),
      });
    }
    else{
      await messagesDocRef.update({
        "last_msg": sendContent,
        "last_time": Timestamp.now(),
        "unreadMessagesCountStudent": FieldValue.increment(1),
        "unreadMessagesCountSpecialist":  0,
      });
    }



  }

  Future<int> getUnreadMessageCount(String uid) async {
    var from_messages = await messagesDocRef
        .collection("msglist")
        .withConverter(
      fromFirestore: Msgcontent.fromFirestore,
      toFirestore: (Msgcontent msg, options) => msg.toFirestore(),
    )
        .where("uid", isNotEqualTo: uid)
        .where("isRead", isEqualTo: "False")
        .get();
    return from_messages.docs.length;
  }

  Future<void> setMessageCountSpecialist() async {
    await messagesDocRef.update({
      'unreadMessagesCountSpecialist': 0,
    });
  }

  Future<void> setMessageCountStudent() async {
    await messagesDocRef.update({
      'unreadMessagesCountStudent': 0,
    });
  }
}
