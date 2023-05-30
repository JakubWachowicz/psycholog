import 'package:get/get.dart';
import 'controller.dart';
class YourReportInfoBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<YourReportInfoConroller>(()=> YourReportInfoConroller());

  }

}