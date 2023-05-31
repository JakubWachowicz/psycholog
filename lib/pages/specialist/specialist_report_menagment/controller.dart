import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';

import '../../../Utils/date.dart';
import '../../../common/stores/user.dart';
import '../../../controller/report_db_controller.dart';
import '../../../entities/messages.dart';
import '../../../entities/report.dart';
import 'package:firebase_auth/firebase_auth.dart' as authP;
import '../../../entities/user.dart';

class SpecialistReportsMenagmentConroller extends GetxController {
  SpecialistReportsMenagmentConroller();
  var state = SpecialistReportMenagmentState();

  final db = FirebaseFirestore.instance;
  late final report_id;

  Future<void> updateCaretaker(String reportId, String caretaker) async {
    try {
      final reportRef =
      FirebaseFirestore.instance.collection('reports').doc(reportId);

      await reportRef.update({'caretaker': caretaker});
      state.caretaker.value = caretaker;

      print('Caretaker updated successfully');
    } catch (e) {
      print('Error updating caretaker: $e');
    }
  }






  final token = UserStore.to.token;







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


  Future<UserData> fetchtUser(String id) async {
    var userSnapshot = await db
        .collection("users")
        .withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, options) => userData.toFirestore(),
    )
        .where("id", isEqualTo: id)
        .get();


      return userSnapshot.docs[0].data();

  }



  Future<void> updatePriority(String reportId, String priority) async {
    try {
      final reportRef =
      FirebaseFirestore.instance.collection('reports').doc(reportId);

      await reportRef.update({'priority': priority});
      state.priority.value = priority;

      print('Caretaker updated successfully');
    } catch (e) {
      print('Error updating caretaker: $e');
    }
  }


  void showPrioritySelection(BuildContext context, RxString value) {
    final List<String> priorityValues = ['1', '2', '3', '4', '5'];

    final popupMenuItems = <PopupMenuEntry<dynamic>>[
      PopupMenuItem<String>(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Set Priority',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        enabled: false,
      ),
      ...priorityValues.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }),
    ];

    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final menuWidth = 200.0;
    final menuHeight = 220.0;

    final position = RelativeRect.fromRect(
      Rect.fromCenter(
        center: overlay.localToGlobal(overlay.size.center(Offset.zero)),
        width: menuWidth,
        height: menuHeight,
      ),
      Offset.zero & MediaQuery.of(context).size,
    );

    showMenu(
      context: context,
      position: position,
      items: popupMenuItems,
    ).then((selectedValue) {
      if (selectedValue != null) {
        value.value = selectedValue;
        updatePriority(report_id,selectedValue);
      }
    });
  }




  var dbController = ReportDbController();
  var listener;

  TextEditingController commentContent = TextEditingController();

  late UserData to_userData;

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


    if (from_messages.docs.isEmpty) {
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
          "to_name": state.title.value ?? "",
          "to_avatar": to_userdata.photourl ?? "",
          "from_name": state.title.value?? "",

        });
      });
    } else {
      if (from_messages.docs.isNotEmpty) {
        Get.toNamed("/chat", parameters: {
          "doc_id": from_messages.docs.first.id,
          "to_uid": to_userdata.id ?? "",
          "to_name": state.title.value ?? "",
          "to_avatar": to_userdata.photourl ?? "",
          "from_name": state.title.value??"",
        });
      }
    }


  }




  void handleSendComment(String content) async{



    var userSnapshot = await db
        .collection("users")
        .withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, options) => userData.toFirestore(),
    )
        .where("id", isEqualTo: UserStore.to.token)
        .get();
    userSnapshot.docs.first.data().name;

    dbController.sendComment(report_id, content, UserStore.to.token,userSnapshot.docs.first.data().name.toString());
  }



  @override
  Future<void> onInit() async {
    super.onInit();
    var data = Get.parameters;
    state.reportId.value = data['reportId'] ?? "";
    print("Tutaj się zatrzymamy");
    print(state.reportId.value);


    var reports =  await db
        .collection("reports")
        .withConverter(
        fromFirestore: Report.fromFirestore,
        toFirestore: (Report report, options) => report.toFirestore())
        .where("reportId", isEqualTo: state.reportId.value)
        .get();
    print(reports.docs.length);

    var report = reports.docs.first;
    report_id = report.id;
    print(report);

    state.reportId.value = report.data().reportId!;
    state.studentId.value = report.data().studentId!;
    state.priority.value = report.data().priority!;
    state.content.value = report.data().content!;
    state.reportType.value = report.data().reportType!;
    state.status.value = report.data().status!;
    state.caretaker.value = report.data().caretaker!;
    state.timeStamp.value = duTimeLineFormat(
      report.data().timestamp!.toDate(),
    );
    state.title.value = report.data().title!;
    print(state.title.value);



    to_userData =await  fetchtUser( state.studentId.value);






    var comments  = dbController.fetchComments(report.id);


    state.commentList.clear();
    listener = comments.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                print('Zmiana');
                state.commentList.insert((0), change.doc.data()!);

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
