
import 'package:get/get.dart';
import '../../student/YourReportInfo/controller.dart';
import 'controller.dart';
class SpecialistReportMenagmentBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistReportsMenagmentConroller>(()=> SpecialistReportsMenagmentConroller());
    Get.lazyPut<YourReportInfoConroller>(()=> YourReportInfoConroller());

  }

}