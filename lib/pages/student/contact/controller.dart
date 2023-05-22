import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:firebase_auth/firebase_auth.dart' as authP;
import 'package:jw_projekt/pages/student/contact/index.dart';

import '../../../entities/messages.dart';
import '../../../entities/specialist.dart';
import '../../../entities/user.dart';


class ContactConroller extends GetxController {
  ContactConroller();

  final ContactState state = ContactState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  var listener;
  var listener2;

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
        .where("from_uid", isEqualTo: to_userdata.id).where("to_uid",isEqualTo: token)
        .get();

    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userdata =
      UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgdata = Msg(
          from_uid: userdata.accessToken,
          to_uid: to_userdata.id,
          from_name: data?.name??"Niepowodzenie",
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
          "from_name": data?.name?? "",

        });
      });
    } else {
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": from_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",
          "from_name": data?.name?? "",
        });
      } else if (to_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": to_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": to_userdata.name ?? "",
          "to_avatar": to_userdata.photourl ?? "",
          "from_name": data?.name?? "",
        });
      }
    }


  }



asyncLoadAllData() async {
    //db.collection("users").where("id", isNotEqualTo: token).withConverter(fromFirestore: UserData.fromFirestore, toFirestore: (UserData userdata,options) =>userdata.toFirestore());
    var data = await db
        .collection("users").where("role",isEqualTo: "specialist")
        .withConverter(
        fromFirestore: UserData.fromFirestore,
        toFirestore: (UserData userdata, options) => userdata.toFirestore());




    /*for (var doc in data.docs) {
      state.messageList.add(doc.data());
    }*/

    var specialistdata =  await db
        .collection("specialists")
        .withConverter(
        fromFirestore: SpecialistData.fromFirestore,
        toFirestore: (SpecialistData userdata, options) => userdata.toFirestore());



    state.messageList.clear();
    state.specialistList.clear();
    listener = data.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.messageList.insert((0), change.doc.data()!);
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

    listener2 = specialistdata.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.specialistList.insert((0), change.doc.data()!);
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
}
