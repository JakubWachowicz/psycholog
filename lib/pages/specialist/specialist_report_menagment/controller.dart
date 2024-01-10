import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jw_projekt/controller/send_message_controller.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';

import '../../../Utils/date.dart';
import '../../../common/stores/user.dart';
import '../../../controller/db_data_controller.dart';
import '../../../controller/report_db_controller.dart';
import '../../../entities/messages.dart';
import '../../../entities/msg_content.dart';
import '../../../entities/report.dart';
import 'package:firebase_auth/firebase_auth.dart' as authP;
import '../../../entities/user.dart';
import  'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistReportsMenagmentConroller extends GetxController {
  SpecialistReportsMenagmentConroller();
  var state = SpecialistReportMenagmentState();

  final db = FirebaseFirestore.instance;
  late var report_id;

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





  FocusNode focus = FocusNode();
  final token = UserStore.to.token;

  late UserData currentUser;





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

  Future<void> updateSate(String reportId, String status) async {
    try {
      final reportRef =
      FirebaseFirestore.instance.collection('reports').doc(reportId);

      await reportRef.update({'status': status});
      state.status.value = status;

      print('Status updated successfully');
    } catch (e) {
      print('Error updating Status: $e');
    }
  }



  void showPrioritySelection(BuildContext context, RxString value) {
    final List<String> priorityValues = ['0', '1', '2','3','4','5'];

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
    final menuHeight = 70.h;

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





  void showStateSelection(BuildContext context, RxString value) {
    final List<String> priorityValues = ['not assigned', 'assigned', 'in progress','done',];

    final popupMenuItems = <PopupMenuEntry<dynamic>>[
      PopupMenuItem<String>(
        child: Container(

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
        updateSate(report_id,selectedValue);
      }
    });
  }




  var dbController = ReportDbController();
  var listener;

  TextEditingController commentContent = TextEditingController();

  late UserData to_userData;


  DbDataController dbDataController = DbDataController();

  goChat() async {
    UserData? data = await fetchCurrentUser()!;
    to_userData = await fetchtUser(state.studentId.value);

    bool isStudent = false;
    //dbDataController.goChat(to_userdata!,data!,false);
    dbController.goToReportChat(report_id,to_userData,data!,isStudent,state.title.value);
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

  final ScrollController scrollController = ScrollController();

  var infoListen;

  initLastMsg() async {

    DocumentReference docRef = db.collection("reports").doc(state.reportId.value);
    QuerySnapshot messagesRef = await docRef.collection("messages").get();
    DocumentReference firstMessageRef = messagesRef.docs.first.reference;

    var data = await docRef
        .collection("messages")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()).where("specialist_uid",isEqualTo:token);

    infoListen = data.snapshots().listen(
          (event) async {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.messages.insert((0), change.doc.data()!);
                print('dodano');
              }
              break;
            case DocumentChangeType.modified:
              var modifiedMessage = change.doc.data();
              if (modifiedMessage != null) {
                // Find the index of the modified message in the list
                print("Tutaj coś nie gra lol");
                var index = state.messages.indexWhere((msg) => msg.messageId == modifiedMessage.messageId);
                print(index);
                print("Tutaj coś nie gra popop");
                if (index != -1) {
                  // Replace the old message with the modified message
                  state.messages[index] = modifiedMessage;
                  print(state.messages[index].last_msg);

                  state.messages.sort((a, b) {
                    final aTime = a.last_time;

                    final bTime = b.last_time;

                    return bTime!.compareTo(aTime!);
                  });
                  state.messages.refresh();






                }}
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed: ${error}"),
    );




  }

  var reportReference;
  @override
  Future<void> onInit() async {
    //focus.addListener(_onFocusChange);
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
    reportReference = report.data();
    print(reportReference.runtimeType);
    report_id = report.id;
    print(report);

    state.reportId.value = report.data().reportId!;
    state.studentId.value = report.data().studentId!;
    state.priority.value = report.data().priority!;
    state.content.value = report.data().content!;
    state.reportType.value = report.data().reportType!;
    state.status.value = report.data().status!;
    state.caretaker.value = report.data().caretaker!;
    state.timeStamp.value = fullDateFormat(
      report.data().timestamp!.toDate(),
    );



    DocumentReference docRef = db.collection("reports").doc(report_id);



    var dataMsg = await docRef
        .collection("messages")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore()).where("specialist_uid",isEqualTo:token);

    state.messages.clear();

    listener = dataMsg.snapshots().listen(
          (event) async {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.messages.insert((0), change.doc.data()!);
                print('dodano');

              }
              break;
            case DocumentChangeType.modified:
              var modifiedMessage = change.doc.data();
              if (modifiedMessage != null) {
                // Find the index of the modified message in the list
                print("Tutaj coś nie gra lol");
                var index = state.messages.indexWhere((msg) => msg.messageId == modifiedMessage.messageId);
                print(index);
                print("Tutaj coś nie gra popop");
                if (index != -1) {
                  // Replace the old message with the modified message
                  state.messages[index] = modifiedMessage;
                  print(state.messages[index].last_msg);

                  state.messages.sort((a, b) {
                    final aTime = a.last_time;

                    final bTime = b.last_time;

                    return bTime!.compareTo(aTime!);
                  });
                  state.messages.refresh();

                }}
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed: ${error}"),
    );





    state.title.value = report.data().title!;
    print(state.title.value);


    currentUser =await  fetchtUser(state.caretaker.value);
    to_userData =await  fetchtUser( state.studentId.value);




    var comments  = dbController.fetchComments(report.id);


    state.commentList.clear();
    listener = comments.snapshots().listen(
          (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
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





@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
