
import 'package:get/get.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
class WelcomeBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(()=> WelcomeController());
  }

}