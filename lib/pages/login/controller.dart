import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/login/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';

class LoginConroller extends GetxController{

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  AuthenticationClontroller auth = AuthenticationClontroller();
  final state = LoginState();
  LoginConroller();

  final db = FirebaseFirestore.instance;

  bool get isEmailValid => true;

  bool get isPasswordValid => true;

  void validateTextFields(String login, String password){

    if(login.length == ""){
      state.emailErrorMessage = Rx<String>("Enter email");
    }
    if(password == ""){
      state.passwordErrorMessage = Rx<String>("Enter password");
    }



  }

  Future<void> handleLogin() async{
      bool isValid = await auth.loginUser(emailController.text, passwordController.text);

      if(isValid){
        Get.offAndToNamed(AppRoutes.Application);
      }
      else{
        print("lol");
        state.errorMessage.value = "Invalid email or password";
        print(state.errorMessage.toString());

      }
      //TODO Save profile
      //UserStore.to.saveProfile()

  }






}