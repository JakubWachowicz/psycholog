import 'package:get/get.dart';
import 'package:jw_projekt/pages/student/report/state.dart';
class ReportConroller extends GetxController{


  final state = ReportState();
  ReportConroller();



  goForm(String reportType)async{
    final result = await Get.toNamed("/reportForm", parameters: {
    "reportType": reportType});
    if (result != null) {
      // Use the returned result from the NewScreen
      print(result);

      state.index.value = 1;
    }


  }

}