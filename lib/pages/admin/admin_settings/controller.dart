import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/routes/routes.dart';
import '../../../common/stores/user.dart';
import 'index.dart';

class AdminSettingsController extends GetxController{

  final state = AdminSettingsState();
  AdminSettingsController();


  Future<void> hangleLogout() async{
    try{
      Get.offAndToNamed(AppRoutes.Login);
      UserStore.to.onLogout();
    }
    catch(e){

    }
  }
  @override
  void onInit() {
    super.onInit();
    List myList = [];


  }

  @override
  void dispose() {

    super.dispose();
  }





}