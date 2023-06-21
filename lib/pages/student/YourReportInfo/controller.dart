import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/report_db_controller.dart';

import '../../../Utils/date.dart';
import '../../../common/routes/routes.dart';
import '../../../controller/db_data_controller.dart';
import '../../../entities/report.dart';
import '../../../entities/user.dart';
import 'index.dart';
import 'package:uuid/uuid.dart';

class YourReportInfoConroller extends GetxController {
  final state = YourReportInfoState();
  ScrollController msgScrolling = ScrollController();
  final user_id = UserStore.to.token;
  ScrollController reportScrolling = ScrollController();
  late final reportType;
  var listener;
  final db = FirebaseFirestore.instance;
  var report_id;
  var docId;
  TextEditingController commentContent = TextEditingController();
  final DbDataController db_controller = DbDataController();
  ReportDbController dbController = ReportDbController();
  void handleSendComment(String content) async{



    var userSnapshot = await db
        .collection("users")
        .withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData userData, options) => userData.toFirestore(),
    )
        .where("id", isEqualTo: user_id)
        .get();
    userSnapshot.docs.first.data().name;

    dbController.sendComment(report_id, content, user_id,userSnapshot.docs.first.data().name.toString());
  }
  @override
  Future<void> onInit() async {
    super.onInit();
    var data = Get.parameters;
    state.reportId.value = data['reportId'] ?? "";






    var reports =  await db
        .collection("reports")
        .withConverter(
        fromFirestore: Report.fromFirestore,
        toFirestore: (Report report, options) => report.toFirestore())
        .where("reportId", isEqualTo: state.reportId.value)
        .get();
    print(reports.docs.length);

    docId = reports.docs.first.id;
    var report = reports.docs.first;
    report_id = report.id;
    print(report);

    state.reportId.value = report.data().reportId!;
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





    var comments  = dbController.fetchComments(docId);


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
