
import 'package:get/get.dart';
import 'package:jw_projekt/pages/admin/admin_settings/controller.dart';


import '../../signin/controller.dart';
import '../../student/YourReportInfo/controller.dart';
import '../../student/your_reports/controller.dart';
import '../specialist_messages/index.dart';
import '../specialist_reports/index.dart';
import 'controller.dart';

class SpecialistApplicationBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistApplicationConroller>(()=> SpecialistApplicationConroller());
    Get.lazyPut<SpecialistMessagesConroller>(()=> SpecialistMessagesConroller());
    Get.lazyPut<AdminSettingsController>(()=> AdminSettingsController());
    Get.lazyPut<SpecialistReportsConroller>(()=> SpecialistReportsConroller());


  }

}