import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../entities/messages.dart';
import '../../../entities/report.dart';
import '../../../entities/reportComment.dart';
class SpecialistReportMenagmentState{

  var reportId = "".obs;
  var studentId = "".obs;
  var caretaker ="".obs;
  var content = "".obs;
  var priority = "".obs;
  var reportType = "".obs;
  var status = "".obs;
  var timeStamp ="".obs;
  var title = "".obs;
  late final from_name = "".obs;

  RxList<Msg> messages = <Msg>[].obs;

  RxList<ReportComment> commentList = <ReportComment>[].obs;

}