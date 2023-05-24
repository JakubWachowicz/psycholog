import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/index.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';

import '../../../Utils/date.dart';
import '../../../entities/report.dart';

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


  }

}
