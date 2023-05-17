import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/chat/state.dart';
import 'package:jw_projekt/pages/login/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';
import '../../entities/msg_content.dart';

class ChatConroller extends GetxController {
  AuthenticationClontroller auth = AuthenticationClontroller();
  final state = ChatState();

  ChatConroller();

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
      sender: name,
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
    });
  }


  void updateIsRead(DocumentReference documentRef, bool isRead) {
    documentRef.update({'isRead': isRead.toString()})
        .then((value) {
      print('isRead updated successfully');
    })
        .catchError((error) {
      print('Failed to update isRead: $error');
    });
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
  @override
  void onInit() {
    super.onInit();

    var data = Get.parameters;
    doc_id = data['doc_id'];
    state.to_uid.value = data['to_uid'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    name = data['from_name'] ?? "";
    print("lLAASgas");
    print(name);
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
