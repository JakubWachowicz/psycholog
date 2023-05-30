import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:firebase_auth/firebase_auth.dart' as authP;

import '../../../entities/messages.dart';
import '../../../entities/msg_content.dart';
import '../../../entities/user.dart';
import 'index.dart';

class MessagesConroller extends GetxController {
  MessagesConroller();

  final MessagesState state = MessagesState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  var listener;


  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  String? getCurrentUserId() {
    authP.FirebaseAuth auth = authP.FirebaseAuth.instance;
    String? currentUser = auth.currentUser?.uid;
    return currentUser;
  }

  Future<UserData?> fetchCurrentUser() async {
    var userSnapshot = await db
        .collection("users")
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .where("id", isEqualTo: getCurrentUserId())
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      return userSnapshot.docs[0].data();
    }

    return null;
  }

  goChat(UserData to_userdata) async {
    UserData? data = await fetchCurrentUser()!;
    print(to_userdata);

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
        .where("from_uid", isEqualTo: to_userdata.id)
        .where("to_uid", isEqualTo: token)
        .get();

    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userdata =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgdata = Msg(
          from_uid: userdata.accessToken,
          to_uid: to_userdata.id,
          from_name: data?.name ?? "Niepowodzenie",
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
          "from_name": data?.name ?? "",
        });
      });
    } else {
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": from_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",
          "from_name": data?.name ?? "",
        });
      } else if (to_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": to_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",
          "from_name": data?.name ?? "",
        });
      }
    }
  }

  late final name;

  void initAsyncChatRefresh() async{

    var data = await db
        .collection("messages")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore());

    state.messages.clear();

    listener = data.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.messages.insert((0), change.doc.data()!);
              }
              break;
            case DocumentChangeType.modified:
              getUnreadMessageCount(change.doc.id);
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed: ${error}"),
    );



  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    UserData? data = await fetchCurrentUser();
    name = data?.name;

   // initAsyncChatRefresh();
  }

  void onRefresh() {

    asyncLoadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
  }

  void onLoading() {

    //state.messageLimit+= 2;
    print(state.messageLimit);
    asyncLoadAllData();

  }
  Future<int> getUnreadMessageCount(String docId) async {
    var from_messages = await db
        .collection("messages")
        .doc(docId)
        .collection("msglist")
        .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .where("uid", isNotEqualTo: token)
        .where("isRead", isEqualTo: "False")
        .get();
    print('Liczba');
    print(from_messages.docs.length);
    return from_messages.docs.length;
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

    for (var msg in from_messages.docs) {
      final unreadCount = await getUnreadMessageCount(msg.id);
      state.unreadMsgCounter[msg.id] = unreadCount;
      print(unreadCount);
      print("Toje saa");
      print(state.unreadMsgCounter[msg.id]);
      print("Toje poo");
    }

    for (var msg in to_messages.docs) {
      final unreadCount = await getUnreadMessageCount(msg.id);
      state.unreadMsgCounter[msg.id] = unreadCount;
      print(unreadCount);
    }

    if (from_messages.docs.isNotEmpty) {
      state.messageList.assignAll(from_messages.docs);
    }
    if (to_messages.docs.isNotEmpty) {
      state.messageList.assignAll(to_messages.docs);
    }
    state.messageList.sort((a, b) {
      final aTime = a.data().last_time;

      final bTime = b.data().last_time;

      return bTime!.compareTo(aTime!);
    });
  }



}
