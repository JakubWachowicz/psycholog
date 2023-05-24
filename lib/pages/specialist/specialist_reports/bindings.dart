
import 'package:get/get.dart';
import 'controller.dart';
class SpecialistReportsBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistReportsConroller>(()=> SpecialistReportsConroller());

  }

}