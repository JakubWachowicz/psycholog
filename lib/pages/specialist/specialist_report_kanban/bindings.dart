
import 'package:get/get.dart';
import 'controller.dart';
class SpecialistReportKanban implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistReportKanbanConroller>(()=> SpecialistReportKanbanConroller());

  }

}