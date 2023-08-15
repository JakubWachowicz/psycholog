import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:random_password_generator/random_password_generator.dart';

class StudentFormConroller extends GetxController {
  final state = StudentFormState();
  final TextEditingController peselController = TextEditingController();
  late final passwordGenerator;

  bool get isPeselValid => true;
  late final PageController pageController;

  changePage(int index) async {
    state.index = index;
  }

  void handlePageChanged(int value) {
    state.index = value;
    print(value);
  }

  void handlePeselSubmit() {
    state.index = 1;
    generatePassword();
    pageController.jumpToPage(1);
  }

  void generatePassword() {
    state.password.value = passwordGenerator.randomPassword();
  }

  void generateLogin() {}

  @override
  void onInit() {
    passwordGenerator = RandomPasswordGenerator();
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
