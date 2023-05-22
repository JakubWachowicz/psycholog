import 'package:get/get.dart';
import 'controller.dart';
class ReportFormBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ReportFormConroller>(()=> ReportFormConroller());

  }

}