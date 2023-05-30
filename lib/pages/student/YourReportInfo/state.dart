import 'package:get/get.dart';
import 'package:jw_projekt/entities/report.dart';
import 'package:jw_projekt/entities/reportComment.dart';
class YourReportInfoState{

  var reportId = "".obs;
  var caretaker ="".obs;
  var content = "".obs;
  var priority = "".obs;
  var reportType = "".obs;
  var status = "".obs;
  var timeStamp ="".obs;
  var title = "".obs;
  late final from_name = "".obs;


  RxList<ReportComment> commentList = <ReportComment>[].obs;
}