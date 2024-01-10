import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';

import '../../../common/routes/routes.dart';
import '../../../controller/db_data_controller.dart';
import '../../../entities/report.dart';
import '../../../entities/user.dart';


class SpecialistReportsConroller extends GetxController {
  SpecialistReportsConroller();

  var listener;
  var state = SpecialistReportsState();
  ScrollController reportScrolling = ScrollController();

  DbDataController _dbDataController = DbDataController();
  Future<UserData?> getProfile(String id) async {

    return await _dbDataController.fetchUser(id);
  }

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
          return bTime!.compareTo(aTime!);
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

  void updateFilterList(){
    state.reportFilteredList.clear();
    state.reportFilteredList.assignAll(state.reportList.value);
    //filterMessages(state.messages, searchController.text);

  }
  void filterReports(String date, String priority, String status, String caretaker) {
    List<Report> filteredList = state.reportList;

    if (priority != "") {
      filteredList = filteredList.where((report) => report.priority!.contains(priority)).toList();
    }

    if (status != "") {
      filteredList = filteredList.where((report) => report.status!.contains(status)).toList();
    }

    if (caretaker != "") {
      filteredList = filteredList.where((report) => report.caretaker!.contains(caretaker)).toList();
    }

    if (date.isNotEmpty) {
      if (date == "From latest") {
        filteredList.sort((a, b) {
          final aTime = a.timestamp;
          final bTime = b.timestamp;
          return bTime!.compareTo(aTime!);
        });
      } else if (date == "From oldest") {
        filteredList.sort((a, b) {
          final aTime = a.timestamp;
          final bTime = b.timestamp;
          return aTime!.compareTo(bTime!);
        });
      }
    }else{
      filteredList.sort((a, b) {
        final aTime = a.timestamp;
        final bTime = b.timestamp;
        return bTime!.compareTo(aTime!);
      });
    }

    state.reportFilteredList.assignAll(filteredList);
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
                updateFilterList();
              }
              break;
            case DocumentChangeType.modified:
              if (change.doc.data() != null) {
                // Find the report in the list and update its priority
                final modifiedReport = change.doc.data()!;
                final index = state.reportList.indexWhere((report) => report.reportId == modifiedReport.reportId);
                if (index != -1) {
                  state.reportList[index] = modifiedReport;
                  updateFilterList();
                }
              }
              updateFilterList();
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
      },
      onError: (error) => print("listen failed: ${error}"),
    );
    updateFilterList();
  }
}
