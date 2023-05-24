
import 'package:get/get.dart';
import 'controller.dart';
class SpecialistChatBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistChatConroller>(()=> SpecialistChatConroller());

  }

}