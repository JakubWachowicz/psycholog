
import 'package:get/get.dart';
import 'controller.dart';
class SpecialistReportMenagmentBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistReportsMenagmentConroller>(()=> SpecialistReportsMenagmentConroller());

  }

}