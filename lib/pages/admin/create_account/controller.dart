import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';


class CreateAccountConroller extends GetxController{

  final state = CreateAccountState();

  final List<String> roles = <String>["student","specialist","admin"];

  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage:state.formTypePage);
  }

  void handlePageChanged(int value) {

    state.formTypePage = value;
    print(value);
  }

  CreateAccountConroller();

  handleRoleChanged(String role) {
    state.currentRole.value = role;

    if(role == "student"){
      if(state.formTypePage != 0){
        state.formTypePage = 0;
      }

    }

    if(role == "specialist"){
      if(state.formTypePage != 1){
        state.formTypePage = 1;
      }

    }
    if(role == "admin"){
      state.formTypePage = 2;
    }
    print(state.formTypePage);

    pageController.jumpToPage(state.formTypePage);

  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }



}