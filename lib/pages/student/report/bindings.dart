
import 'package:get/get.dart';
import '../your_reports/index.dart';
import 'controller.dart';
class ReportBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ReportConroller>(()=> ReportConroller());
    Get.lazyPut<YourReportsConroller>(()=> YourReportsConroller());
    Get.lazyPut<YourReportsConroller>(()=> YourReportsConroller());

  }

}