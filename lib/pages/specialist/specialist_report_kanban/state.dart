import 'package:get/get.dart';

import '../../../entities/msg_content.dart';
import '../../../entities/report.dart';

class SpecialistReportKanbanState{

  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_uid="".obs;
  var to_name="".obs;
  var to_avatar = "".obs;
  late final from_name = "".obs;
  RxList<Report> reportList = <Report>[].obs;
}