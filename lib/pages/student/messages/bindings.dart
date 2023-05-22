
import 'package:get/get.dart';
import 'controller.dart';
class MessagesBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MessagesConroller>(()=> MessagesConroller());

  }

}