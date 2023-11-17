import 'package:get/get.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';


class ProfileDataController extends GetxController {
  static ProfileDataController get to => Get.find();
  static DbDataController _dbDataController =  DbDataController();
  static Rx<String> profileAvatar = "assets/logo.jpg".obs;
  static Rx<String?> profileName = "".obs;

  static void initialize() {
    Get.put(ProfileDataController());
    initProfile();


  }



  void setAvatar(String img){
    _dbDataController.updateData("photourl", img);
    profileAvatar.value = img;

  }

  static Future<void> initProfile() async {
    profileAvatar.value = await _dbDataController.getPhoto();
    profileName.value = await _dbDataController.getName();
  }

}
