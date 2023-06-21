
import 'package:get/get.dart';
import '../../../controller/profile_data_controller.dart';
import 'controller.dart';
class ProfileBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ProfileConroller>(()=> ProfileConroller());
    Get.lazyPut<ProfileDataController>(()=> ProfileDataController());

  }

}