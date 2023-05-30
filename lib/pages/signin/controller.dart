import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jw_projekt/pages/signin/state.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';


class SigninConroller extends GetxController{

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController photoController = TextEditingController();




  AuthenticationClontroller auth = AuthenticationClontroller();
  final state = SigninState();
  SigninConroller();

  final db = FirebaseFirestore.instance;

  bool get isEmailValid => true;

  bool get isPasswordValid => true;


  handleRoleChanged(String role) {
    state.currentRole.value = role;
  }

  Future<void> handleSignIn() async{
    try{
      auth.registerUser(nameController.text,"LastName",emailController.text, passwordController.text,"PESEL",state.currentRole.value);

      passwordController.text ="";
      nameController.text = "";
      photoController.text = "";
      Get.snackbar("Succes", "created new account");

    }
    catch(e){

    }
  }

  Future<void> hangleLogout() async{
    try{
      Get.offAndToNamed(AppRoutes.Login);
      UserStore.to.onLogout();

    }
    catch(e){

    }
  }






}