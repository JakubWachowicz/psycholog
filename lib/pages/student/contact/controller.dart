import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:firebase_auth/firebase_auth.dart' as authP;
import 'package:jw_projekt/controller/db_data_controller.dart';
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

  DbDataController dbDataController = DbDataController();
  goChat(UserData to_userdata) async {

    UserData? data = await fetchCurrentUser()!;
    dbDataController.goChat(data!, to_userdata, true);
    print(to_userdata);

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
