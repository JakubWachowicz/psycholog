import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/pages/messages/state.dart';
import '../../entities/user.dart';
import '../../entities/messages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class MessagesConroller extends GetxController {
  MessagesConroller();

  final MessagesState state = MessagesState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  var listener;


  final RefreshController refreshController = RefreshController(
      initialRefresh:true,
      );
  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  goChat(UserData to_userdata) async {
    var from_messages = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: to_userdata.id)
        .get();

    var to_messages = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo:to_userdata.id).where("to_uid",isEqualTo: token )
        .get();

    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userdata =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgdata = Msg(
          from_uid: userdata.accessToken,
          to_uid: to_userdata.id,
          from_name: userdata.displayName,
          to_name: to_userdata.name,
          from_avatar: userdata.photoUrl,
          to_avatar: to_userdata.photourl,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0);
      db
          .collection("messages")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) => msg.toFirestore())
          .add(msgdata)
          .then((value) {
        Get.toNamed("/chat", parameters: {
          "doc_id": value.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",

        });
      });
    } else {
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": from_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",
        });
      } else if (to_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": to_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",
        });
      }
    }
  }

  void onRefresh() {
    asyncLoadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }

  void onLoading() {
    asyncLoadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_){
      refreshController.refreshFailed();
    });
  }




  asyncLoadAllData() async {
    var from_messages = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("from_uid", isEqualTo: token)
        .get();
    var to_messages = await db
        .collection("messages")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("to_uid", isEqualTo: token)
        .get();
    state.messageList.clear();
    if (from_messages.docs.isNotEmpty) {
      state.messageList.assignAll(from_messages.docs);
    }
    if (to_messages.docs.isNotEmpty) {
      state.messageList.assignAll(to_messages.docs);
    }
  }

/*asyncLoadAllData() async {
    //db.collection("users").where("id", isNotEqualTo: token).withConverter(fromFirestore: UserData.fromFirestore, toFirestore: (UserData userdata,options) =>userdata.toFirestore());
    var data = await db
        .collection("users")
        .withConverter(
        fromFirestore: UserData.fromFirestore,
        toFirestore: (UserData userdata, options) => userdata.toFirestore())
        .get();

    for (var doc in data.docs) {
      state.messageList.add(doc.data());
    }
  }*/
}
