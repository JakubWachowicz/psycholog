
import 'package:get/get.dart';
import '../../student/messages/controller.dart';
import 'controller.dart';
class SpecialistMessagesBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<SpecialistMessagesConroller>(()=> SpecialistMessagesConroller());
    Get.lazyPut<MessagesConroller>(()=> MessagesConroller());

  }

}