
import 'package:get/get.dart';
import 'controller.dart';
class SpecialistMessagesBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistMessagesConroller>(()=> SpecialistMessagesConroller());

  }

}