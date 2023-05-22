import 'package:get/get.dart';
import 'package:jw_projekt/pages/student/report/state.dart';
class ReportConroller extends GetxController{


  final state = ReportState();
  ReportConroller();



  goForm(String reportType){
    Get.offAndToNamed("/reportForm", parameters: {
    "reportType": reportType});


  }

}