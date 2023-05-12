
import 'package:get/get.dart';
import 'package:jw_projekt/pages/login/controller.dart';

import '../../common/stores/config.dart';
import 'controller.dart';
class ReportFormBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ReportFormBinding>(()=> ReportFormBinding());

  }

}