import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/send_message_controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_chat/state.dart';
import 'package:jw_projekt/pages/student/chat/state.dart';

import '../../../common/routes/routes.dart';
import '../../../controller/auth_controller.dart';
import '../../../entities/msg_content.dart';

import 'package:async/async.dart';


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

  late SendMessageController sendMessageController;

  sendMessage() async {
    sendMessageController.sendMessage(textController.text, name);
    textController.clear();
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

    sendMessageController = SendMessageController(doc_id, UserStore.to.token!, state.to_uid.value, false);
    state.msgcontentList.clear();
    //sendMessageController.updateIsRead(doc_id);
    listener = messages.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.msgcontentList.insert((0), change.doc.data()!);
                if(change.doc.data()?.uid != user_id){
                  print('Tutaj trzeba się zatrzymać');
                  sendMessageController.updateIsRead(change.doc.reference);
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
  //static const oneSecond = const Duration(seconds: 25);

  @override
  void onInit() {
    super.onInit();




    var data = Get.parameters;
    doc_id = data['doc_id'];
    state.to_uid.value = data['to_uid'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    state.from_uid.value = data['from_uid'] ?? "";

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
