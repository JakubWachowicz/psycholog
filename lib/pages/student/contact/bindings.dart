
import 'package:get/get.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'controller.dart';
class MessagesBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ContactConroller>(()=> ContactConroller());

  }

}