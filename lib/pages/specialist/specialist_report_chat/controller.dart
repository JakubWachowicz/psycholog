import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/send_message_controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_chat/state.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_chat/state.dart';
import 'package:jw_projekt/pages/student/chat/state.dart';

import '../../../common/routes/routes.dart';
import '../../../controller/auth_controller.dart';
import '../../../entities/msg_content.dart';

class SpecialistReportChatConroller extends GetxController {
  AuthenticationClontroller auth = AuthenticationClontroller();
  final state = SpecialistReportChatState();

  SpecialistReportChatConroller();

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
    print(state.specialist_name.value + "LOO");
    textController.clear();
  }
  @override
  Future<void> onReady() async {
    super.onReady();

    DocumentReference docRef = db.collection("reports").doc(doc_id);
    QuerySnapshot messagesRef = await docRef.collection("messages").get();
    DocumentReference firstMessageRef = messagesRef.docs.first.reference;







    sendMessageController = SendMessageController(
      doc_id,
      UserStore.to.token!,
      state.spcialist_uid.value,
      false,
      messagesDocRef: firstMessageRef,
    );
    var messages = await sendMessageController.getMessageList();
    // Wait for the asynchronous task to complete before proceeding

    sendMessageController.read();

    state.msgcontentList.clear();

    listener = messages.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                print("Added message: ${change.doc.data()}");
                state.msgcontentList.insert(0, change.doc.data()!);
                if (change.doc.data()?.uid != user_id) {
                  sendMessageController.read();
                }
              }
              break;
            case DocumentChangeType.modified:
              break;
            case DocumentChangeType.removed:
              break;
          }
          sendMessageController.setMessageCountSpecialist();
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
    doc_id = data['report_id'];
    state.spcialist_uid.value = data['specialist_uid'] ?? "";
    state.specialist_name.value = data['specialist_name'] ?? "";
    state.specialist_avatar.value = data['specialist_avatar'] ?? "";
    state.student_uid.value = data['student_uid'] ?? "";
    state.student_name.value = data["student_name"] ?? "";
    state.report_title = data["report_title"] ?? "";
    name = state.specialist_name.value;
    topName = data['student_name'] ?? "MAmy errora w tym miejscu";
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }
}
