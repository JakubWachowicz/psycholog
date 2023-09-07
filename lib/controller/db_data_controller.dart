import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/send_message_controller.dart';
import 'package:jw_projekt/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as authP;
import 'package:firebase_database/firebase_database.dart';
import '../common/routes/routes.dart';
import '../common/stores/user.dart';
import '../entities/messages.dart';
import 'package:get/get.dart';

class DbDataController {
  final db = FirebaseFirestore.instance;

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

  final token = UserStore.to.token;
 void  goChat(

      UserData studentData,
      UserData specialistData,
      bool isStudent,
      ) async {
    UserData? data = await fetchCurrentUser()!;

    var messages;
    if (isStudent) {
      messages = await db
          .collection("messages")
          .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      )
          .where("student_uid", isEqualTo: token)
          .get();
    } {
      messages = await db
          .collection("messages")
          .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      )
          .where("specialist_uid", isEqualTo: token)
          .get();
    }

    if (messages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userdata =
      UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgdata = Msg(
        student_uid: studentData.id!,
        specialist_uid: specialistData.id!,
        student_name: studentData.name!,
        specialist_name: specialistData.name!,
        student_avatar: userdata.photoUrl,
        specialist_avatar: specialistData.photourl,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      db
          .collection("messages")
          .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      )
          .add(msgdata)
          .then((value) {
        Get.toNamed(AppRoutes.SpecialistChat, parameters: {
          "doc_id": value.id,
          "specialist_uid": specialistData.id ?? "",
          "student_uid": studentData.id ?? "",
          "specialist_name": specialistData.name ?? "",
          "specialist_avatar": specialistData.photourl ?? "",
          "student_name":studentData.name ?? "",
        });
      });
    } else {
      if (messages.docs.isNotEmpty) {
        Get.toNamed(AppRoutes.SpecialistChat, parameters: {
          "doc_id": messages.docs.first.id,
          "student_uid": messages.docs.first.data().student_uid ?? "error",
          "specialist_uid": messages.docs.first.data().specialist_uid ?? "errorName",
          "specialist_name": messages.docs.first.data().specialist_name ?? "errorToName",
          "student_name": messages.docs.first.data().student_name ?? "errorToName2",
        });

        SendMessageController sendMessageController =
        SendMessageController(messages.docs.first.id,
            messages.docs.first.data().student_uid!, specialistData.id!, false);
        sendMessageController.updateIsRead();
      }
    }
  }

  void goChatByMsg(Msg item){
   if(UserStore.to.role == "student"){
     Get.toNamed(AppRoutes.Chat, parameters: {
       "doc_id": item.messageId!,
       "specialist_uid": item.specialist_uid,
       "specialist_name":item.specialist_name,
       "student_uid":item.student_uid,
       "student_name": item.student_name,
       "student_avatar": item.student_avatar??"Brak",
       "specialist_avatar":item.specialist_avatar??"Brak",
       "student_name": item.student_name,
     });
   }else{
     Get.toNamed(AppRoutes.SpecialistChat, parameters: {
       "doc_id": item.messageId!,
       "specialist_uid": item.specialist_uid,
       "specialist_name":item.specialist_name,
       "student_uid":item.student_uid,
       "student_name": item.student_name,
       "student_avatar": item.student_avatar??"Brak",
       "specialist_avatar":item.specialist_avatar??"Brak",
       "student_name": item.student_name,
     });
   }

  }


  final _database = FirebaseDatabase.instance;

  Future<void> updateData(String key, dynamic value) async {
    var collection = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: getCurrentUserId());
    print(await collection.get());
    var querySnapshots = await collection.get();
    for (var doc in querySnapshots.docs) {
      print(doc);
      await doc.reference.update({
        key: value,
      });
    }
  }

  String? getUser() {
    UserData user = fetchCurrentUser() as UserData;
    return user.role;
  }

  Future<String?> getName() async {
    var user = await fetchCurrentUser();
    return user?.name;
  }

  Future<String?> getAvatar(id) async {
    var userSnapshot = await db
        .collection("users")
        .withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, options) => userData.toFirestore(),
    )
        .where("id", isEqualTo: id)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      var user = userSnapshot.docs[0].data();
      return user.photourl;
    }
    return 'assets/logo.png';
  }

  UserData getUSerData() {
    UserData user = fetchCurrentUser() as UserData;
    return user;
  }

  Future<String> getPhoto() async {
    var user = await fetchCurrentUser();
    return user!.photourl ?? "assets/logo.jpg";
  }

  String? getCurrentUserId() {
    authP.FirebaseAuth auth = authP.FirebaseAuth.instance;
    String? currentUser = auth.currentUser?.uid;
    print(currentUser);
    return currentUser;
  }
}
