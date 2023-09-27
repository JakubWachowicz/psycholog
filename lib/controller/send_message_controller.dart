import 'package:jw_projekt/common/routes/routes.dart';

import '../entities/msg_content.dart';
import  'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SendMessageController{

  late String uid;
  late String to_uid;
  final db = FirebaseFirestore.instance;
  late String doc_id;
  late bool isItStudent;
  SendMessageController(String this.doc_id,this.uid,this.to_uid,this.isItStudent);


  Future<void> updateIsRead() async {

    if(Get.currentRoute.contains(AppRoutes.Chat)){

      if(isItStudent){
        await db.collection("messages").doc(doc_id).update({
          "unreadMessagesCountStudent":await getUnreadMessageCount(doc_id,uid),
          "unreadMessagesCountSpecialist":await getUnreadMessageCount(doc_id,to_uid),
        });
      }

    }else {
      if(Get.currentRoute.contains(AppRoutes.SpecialistChat)){
        await db.collection("messages").doc(doc_id).update({
          "unreadMessagesCountStudent":await getUnreadMessageCount(doc_id,to_uid),
          "unreadMessagesCountSpecialist":await getUnreadMessageCount(doc_id,uid),
        });
      }
      }}



  readAllMessages(int unreadMessages) async {


    QuerySnapshot unreadMessagesQuery = await db
        .collection("messages")
        .doc(doc_id)
        .collection("msglist").where('sender',isNotEqualTo: uid).where('isRead',isEqualTo: "False")
        .get();
    print(unreadMessagesQuery);

    print("Jestem tutaj");
    int i = 68;
    for (QueryDocumentSnapshot messageSnapshot in unreadMessagesQuery.docs) {
      // Update the 'isRead' field to true
      print(i);
      await db.collection("messages")
        .doc(doc_id)
        .collection("msglist").doc(messageSnapshot.id).update({
        'isRead': "True",
      });

  }}



  sendMessage(String message,String senderName) async {

    if( message.trim() == "") return;
    String sendContent = message.trim();
    final content = Msgcontent(
      sender: senderName,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
      uid: uid,
      isRead: "False",
    );
    await db
        .collection("messages")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgcontent, options) =>
            msgcontent.toFirestore())
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id ${doc.id}");
      //TODO:Przetestować czy działa
      //Get.focusScope?.unfocus();
    });
    await db.collection("messages").doc(doc_id).update({
      "last_msg": sendContent,
      "last_time": Timestamp.now(),
      "unreadMessagesCountStudent":0,
      "unreadMessagesCountSpecialist":0,
    });

    if(isItStudent){
      await db.collection("messages").doc(doc_id).update({
        "unreadMessagesCountStudent":await getUnreadMessageCount(doc_id,uid),
        "unreadMessagesCountSpecialist":await getUnreadMessageCount(doc_id,to_uid),
      });
    }else{
      await db.collection("messages").doc(doc_id).update({
        "unreadMessagesCountStudent":await getUnreadMessageCount(doc_id,to_uid),
        "unreadMessagesCountSpecialist":await getUnreadMessageCount(doc_id,uid),
      });
    }

  }

  Future<int> getUnreadMessageCount(String docId,String uid) async {
    var from_messages = await db
        .collection("messages")
        .doc(docId)
        .collection("msglist")
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .where("uid", isNotEqualTo: uid)
        .where("isRead", isEqualTo: "False")
        .get();
    print('Liczba');
    print(from_messages.docs.length);
    return from_messages.docs.length;
  }

}