import 'package:get/get.dart';

class SpecialistFormState {
  Rx<String> currentRole = "student".obs;

  set setRole(value) => currentRole.value = value;
}
