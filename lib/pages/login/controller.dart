import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/login/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';
import '../../controller/db_data_controller.dart';
import '../../entities/user.dart';



class LoginConroller extends GetxController{

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  AuthenticationClontroller auth = AuthenticationClontroller();

  final FirebaseAuth authID = FirebaseAuth.instance;
  final state = LoginState();
  LoginConroller();

  final db = FirebaseFirestore.instance;


  final dbDataController = DbDataController();

  bool get isEmailValid => true;

  bool get isPasswordValid => true;
  final token = UserStore.to.token;

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
      print("TO jest token:");
      print(token);


      if(isValid){

        final User curUser = authID.currentUser!;
        final uid = curUser.uid;
        UserStore.to.setToken(uid);
        UserData? user =await dbDataController.fetchCurrentUser();
        if(user?.role == 'admin'){

          UserStore.to.setRole('admin');
          Get.offAndToNamed(AppRoutes.AdminApplication);
        }
        else if(user?.role == 'specialist'){
          UserStore.to.setRole('specialist');
          Get.offAndToNamed(AppRoutes.SpecialistApplication);
        }
        else{
          UserStore.to.setRole('student');
          Get.offAndToNamed(AppRoutes.Application);
        }

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