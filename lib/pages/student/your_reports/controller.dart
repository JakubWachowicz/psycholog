import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/routes/routes.dart';
import '../../../entities/report.dart';
import 'index.dart';
import 'package:uuid/uuid.dart';

class YourReportsConroller extends GetxController {
  final state = YourReportsState();

  final user_id = UserStore.to.token;
  ScrollController reportScrolling = ScrollController();
  late final reportType;
  var listener;
  final db = FirebaseFirestore.instance;


  void goReport(Report report){
    print(report.reportId);
    Get.toNamed(AppRoutes.YourReportInfoPage,parameters: {
      "reportId": report.reportId!,

    });
  }

  Future<void> loadAllReports() async {
    var data = await db
        .collection("reports")
        .where("studentId", isEqualTo: user_id)
        .withConverter(
            fromFirestore: Report.fromFirestore,
            toFirestore: (Report report, options) => report.toFirestore());

    state.reportList.clear();


    listener = data.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.reportList.insert((0), change.doc.data()!);
                state.reportList.sort((a, b) {
                  final aTime = a.timestamp;
                  final bTime = b.timestamp;
                  return bTime!.compareTo(aTime!);
                });
                state.reportList.refresh();
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


    state.reportList.sort((a, b) {
      final aTime = a.timestamp;
      final bTime = b.timestamp;
      return bTime!.compareTo(aTime!);
    });
    state.reportList.refresh();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAllReports();


  }
}
