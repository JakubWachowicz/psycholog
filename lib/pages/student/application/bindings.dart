
import 'package:get/get.dart';
import 'package:jw_projekt/pages/student/your_reports/index.dart';


import '../../signin/controller.dart';
import '../contact/index.dart';
import '../messages/index.dart';
import '../report/index.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ApplicationConroller>(()=> ApplicationConroller());
    Get.lazyPut<MessagesConroller>(()=>MessagesConroller());
    Get.lazyPut<ContactConroller>(()=>ContactConroller());
    Get.lazyPut<SigninConroller>(()=>SigninConroller());
    Get.lazyPut<ReportConroller>(()=>ReportConroller());
    Get.lazyPut<YourReportsConroller>(()=> YourReportsConroller());

  }

}