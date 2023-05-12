import 'package:get/get.dart';
class SigninState{

  Rx<String> currentRole ="student".obs;
  set setRole(value) => currentRole.value = value;

  final List<String> roles = <String>["student","specialist","admin"];

}