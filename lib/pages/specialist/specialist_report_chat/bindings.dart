
import 'package:get/get.dart';
import '../specialist_chat/controller.dart';
import 'controller.dart';
class SpecialistReportChatBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistReportChatConroller>(()=> SpecialistReportChatConroller());
    Get.lazyPut<SpecialistChatConroller>(()=> SpecialistChatConroller());

  }

}