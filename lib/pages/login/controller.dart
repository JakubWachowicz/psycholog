import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/login/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';
import '../../controller/db_data_controller.dart';
import '../../entities/user.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../view/widgets/text_input_field.dart';

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
  late StreamSubscription<bool> keyboardSubscription;


  late TextInputField emailInputField;
  late TextInputField passwordInputField;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    passwordInputField = TextInputField(
      controller: passwordController,
      labelText: 'password',
      icon: Icons.lock,
      isObscured: true,
      errorMessage: 'Invalid password',

    );

    emailInputField = TextInputField(
      controller: emailController,
      labelText: 'email',
      icon: Icons.email_outlined,
      isObscured: false,
      errorMessage: 'Invalid email',

    );




    emailController.addListener(() {
      state.areAllFieldsEntered.value = checkIfAllFieldsAreEntenred(passwordController.text,emailController.text);
    });
    passwordController.addListener(() {
      state.areAllFieldsEntered.value = checkIfAllFieldsAreEntenred(passwordController.text,emailController.text);
    });


  }
  @override
  void onReady() {
    super.onReady();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      state.isKeyboardActive.value= visible;
      print("isKeyboard active update " + state.isKeyboardActive.value.toString());
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool checkIfAllFieldsAreEntenred(String email,String password){
    if(email =="" || password == ""){
      return false;
    }
    return true;
  }

  void validateTextFields(String login, String password){
    login = login.trim();
    password = password.trim();
    print("Test "+login);
    print("null chyba");
    if(login == null ||login.trim() ==  ""){
      state.emailErrorMessage = Rx<String>("Enter email");

      emailInputField.setIsValid(false);
      state.isEmailValid.value = false;

    }
    if(password.trim() == ""){
      state.passwordErrorMessage = Rx<String>("Enter password");
      passwordInputField.setIsValid(false);
      state.isPasswordValid.value = false;
    }



  }

  
  Future<void> handleLogin() async{

      print('lol');
      validateTextFields(emailController.text, passwordController.text);
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

          print("Moja rolo to psycholog");
          UserStore.to.setRole('specialist');
          Get.offAndToNamed(AppRoutes.SpecialistApplication);
        }
        else{
          print("Moja rolo to student");
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

      //UserStore.to.saveProfile();

  }






}