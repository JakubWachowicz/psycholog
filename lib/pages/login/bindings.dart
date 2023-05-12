
import 'package:get/get.dart';
import 'package:jw_projekt/pages/login/controller.dart';

import '../../common/stores/config.dart';
class LoginBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<LoginConroller>(()=> LoginConroller());

  }

}