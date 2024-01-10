import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';


class LoginData{
  final String email;
  final String password;
  LoginData(this.email,this.password);
}





Future<void> test() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}


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