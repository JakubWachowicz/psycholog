import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class SpecialistFormConroller extends GetxController {
  final state = SpecialistFormState();

  final List<String> roles = <String>["student", "specialist", "admin"];

  SpecialistFormConroller();

  handleRoleChanged(String role) {
    state.currentRole.value = role;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
