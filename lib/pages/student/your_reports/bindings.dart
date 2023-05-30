import 'package:get/get.dart';
import 'controller.dart';
class YourReportsBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<YourReportsConroller>(()=> YourReportsConroller());

  }

}