import 'package:get/get.dart';
class LoginState{

  Rx<String> passwordErrorMessage ="".obs;
  Rx<String> emailErrorMessage ="".obs;
  Rx<String> errorMessage ="".obs;
  Rx<bool> isKeyboardActive = false.obs;

  Rx<bool> isEmailValid = true.obs;
  Rx<bool> isPasswordValid = true.obs;
  Rx<bool> areAllFieldsEntered = false.obs;
}