
import 'package:get/get.dart';
import 'controller.dart';
class ReportBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ReportConroller>(()=> ReportConroller());

  }

}