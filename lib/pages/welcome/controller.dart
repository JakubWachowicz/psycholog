import 'package:get/get.dart';
import 'package:jw_projekt/pages/welcome/state.dart';

import '../../common/routes/routes.dart';
import '../../common/stores/config.dart';

class WelcomeController extends GetxController{


  final state = WelcomeState();
  WelcomeController();
  changePage(int index)async{
    state.index.value = index;

  }

  Future<void> handleSignIn() async {

    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.Login);
  }
}