
import 'package:get/get.dart';
import 'package:jw_projekt/pages/application/controller.dart';
import 'package:jw_projekt/pages/messages/controller.dart';
import 'package:jw_projekt/pages/contact/controller.dart';

import '../../common/stores/config.dart';
import '../report/controller.dart';
import '../signin/controller.dart';
class ApplicationBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ApplicationConroller>(()=> ApplicationConroller());
    Get.lazyPut<MessagesConroller>(()=>MessagesConroller());
    Get.lazyPut<ContactConroller>(()=>ContactConroller());
    Get.lazyPut<SigninConroller>(()=>SigninConroller());
    Get.lazyPut<ReportConroller>(()=>ReportConroller());

  }

}