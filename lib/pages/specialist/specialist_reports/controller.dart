import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';

import '../../../common/routes/routes.dart';
import '../../../entities/report.dart';


class SpecialistReportsConroller extends GetxController {
  SpecialistReportsConroller();

  var listener;
  var state = SpecialistReportsState();
  ScrollController reportScrolling = ScrollController();

  void goReport(Report report){
    print(report.reportId);
    Get.toNamed(AppRoutes.SpecialistReportMenagment,parameters: {
      "reportId": report.reportId!,
    });
  }
  void sortReports(SortReportsBy sortType) {
    print("rozpoczęto sortowanie");
    print(sortType);
    switch (sortType) {
      case SortReportsBy.Timestamp:
        state.reportList.sort((a, b) {
          final aTime = a.timestamp;
          final bTime = b.timestamp;
          return bTime!.compareTo(aTime!);
        });
        print('Posortowano po dacie');
        break;
      case SortReportsBy.Priority:
        state.reportList.sort((a, b) {
          final aTime = a.priority;
          final bTime = b.priority;
          if(a.priority == "notAssigned"){
            return 0;
          }if(b.priority == "notAssigned"){
            return 1;
          }
          return aTime!.compareTo(bTime!);
        });
        print("Posortowano po nazwie");
        break;
      case SortReportsBy.Title:
        state.reportList.sort((a, b) {
          final aTime = a.title;
          final bTime = b.title;
          return aTime!.compareTo(bTime!);
        });
        print("Posortowano po nazwie");
        break;
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    final db = FirebaseFirestore.instance;
    var reports = db
        .collection("reports")
        .withConverter(
            fromFirestore: Report.fromFirestore,
            toFirestore: (Report report, options) => report.toFirestore())
        .orderBy("timestamp", descending: false);

    state.reportList.clear();
    listener = reports.snapshots().listen(
      (event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                state.reportList.insert((0), change.doc.data()!);
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
