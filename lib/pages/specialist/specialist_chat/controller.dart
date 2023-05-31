import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/pages/specialist/specialist_chat/state.dart';
import 'package:jw_projekt/pages/student/chat/state.dart';

import '../../../common/routes/routes.dart';
import '../../../controller/auth_controller.dart';
import '../../../entities/msg_content.dart';




class SpecialistChatConroller extends GetxController {
  AuthenticationClontroller auth = AuthenticationClontroller();
  final state = SpecialistChatState();

  SpecialistChatConroller();

  var doc_id = null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;
  late final sender;



  sendMessage() async {
    if( textController.text.trim() == "") return;
    String sendContent = textController.text;
    final content = Msgcontent(
      sender: topName,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
      uid: user_id,
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
      textController.clear();
      //TODO:Przetestować czy działa
      //Get.focusScope?.unfocus();
    });
    await db.collection("messages").doc(doc_id).update({
      "last_msg": sendContent,
      "last_time": Timestamp.now(),
      "unreadMessagesCountStudent":await getUnreadMessageCount(doc_id,UserStore.to.token!),
      "unreadMessagesCountSpecialist":await getUnreadMessageCount2(doc_id,UserStore.to.token!),
    });


  }


  Future<int> getUnreadMessageCount2(String docId,String uid) async {
    var from_messages = await db
        .collection("messages")
        .doc(docId)
        .collection("msglist")
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .where("uid", isNotEqualTo:uid)
        .where("isRead", isEqualTo: "False")
        .get();
    print('Liczba');
    print(from_messages.docs.length);
    return from_messages.docs.length;
  }

  Future<int> getUnreadMessageCount(String docId,String uid) async {
    var from_messages = await db
        .collection("messages")
        .doc(docId)
        .collection("msglist")
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .where("uid", isEqualTo:uid)
        .where("isRead", isEqualTo: "False")
        .get();
    print('Liczba');
    print(from_messages.docs.length);
    return from_messages.docs.length;
  }


  Future<void> updateIsRead(DocumentReference documentRef, bool isRead) async {

    print("________________________________");
    print(Get.currentRoute);
    if(Get.currentRoute.contains(AppRoutes.SpecialistChat)){
      documentRef.update({'isRead': isRead.toString()})
          .then((value) {
        print('isRead updated successfully');
      })
          .catchError((error) {
        print('Failed to update isRead: $error');
      });
      await db.collection("messages").doc(doc_id).update({

        "unreadMessagesCountStudent":await getUnreadMessageCount(doc_id,sender),
        "unreadMessagesCountSpecialist":await getUnreadMessageCount(doc_id,UserStore.to.token!),
      });
    }

  }


  @override
  void onReady() {
    super.onReady();
    var messages = db
        .collection("messages")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgcontent, options) =>
                msgcontent.toFirestore())
        .orderBy("addtime", descending: false);

    state.msgcontentList.clear();
    listener = messages.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.msgcontentList.insert((0), change.doc.data()!);
                if(change.doc.data()?.uid != user_id){
                  print('Tutaj trzeba się zatrzymać');
                  updateIsRead(change.doc.reference, true);
                }
              }
              break;
            case DocumentChangeType.modified:
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed: ${error}"),
    );
  }

  late final name;
  late final topName;


  @override
  void onInit() {
    super.onInit();




    var data = Get.parameters;
    doc_id = data['doc_id'];
    state.to_uid.value = data['to_uid'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    name = state.to_name.value;
    topName = data['from_name']?? "MAmy errora w tym miejscu";

  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
