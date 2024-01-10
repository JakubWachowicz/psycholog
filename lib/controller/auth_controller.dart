import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import 'package:jw_projekt/pages/welcome/index.dart';

import '../Utils/constants.dart';
import '../Utils/routes_util.dart';
import '../common/stores/user.dart';
import '../entities/specialist.dart';
import '../entities/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationClontroller extends GetxController {
  static AuthenticationClontroller instance = Get.find();
  late Rx<User?> _user;
  final db = FirebaseFirestore.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => WelcomePage());
    } else {
      //UserStore.to.saveProfile(user);
    }
  }

  Future<bool> registerUser(String firstName, String lastName, String email,
      String password, String pesel, String role) async {
    try {
      if (firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          pesel.isNotEmpty) {
        var cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        var userbase = await db
            .collection("users")
            .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userdata, options) =>
                    userdata.toFirestore())
            .where("id", isEqualTo: cred.user!.uid)
            .get();

        if (userbase.docs.isEmpty) {
          final data = UserData(
              id: cred.user!.uid,
              name: firstName,
              email: email,
              photourl: "testPhoto",
              location: "TestLocation",
              fcmtoken: "",
              addtime: Timestamp.now(),
              role: role);
          print("Testowanko");
          var userbase = await db
              .collection("users")
              .withConverter(
                  fromFirestore: UserData.fromFirestore,
                  toFirestore: (UserData userdata, options) =>
                      userdata.toFirestore())
              .add(data);
          if (role == "specialist") {
            SpecialistData specialistData = SpecialistData(
                role: role,
                id: cred.user!.uid,
                description:
                    "As a school psychologist, I am a caring and qualified professional who works tirelessly to support students' ");

            var userbase = await db
                .collection("specialists")
                .withConverter(
                fromFirestore: SpecialistData.fromFirestore,
                toFirestore: (SpecialistData userdata, options) =>
                    userdata.toFirestore())
                .add(specialistData);
          }

        } else {
          print("cosss");
        }
      } else {
        Get.snackbar("Error creating account", "enter all fields");
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
    return true;
  }



  Future<bool> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        var cred = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        UserLoginResponseEntity profile = UserLoginResponseEntity();
        profile.accessToken = cred.user!.uid;
        profile.email = email;
        profile.password = password;
        profile.photoUrl = cred.user!.photoURL;
        profile.displayName = cred.user!.displayName;
        UserStore.to.saveProfile(profile);
        print('login succesed');
        return true;
        //var userbase = await db.collection("users").withConverter(fromFirestore: UserData.fromFirestore, toFirestore: (UserData userdata,options)=>userdata.toFirestore()).where("id",isEqualTo: cred.user!.uid).get();

        /* for(var doc in userbase.docs){
          UserData profile = doc.data();

         UserStore.to.saveProfile(profile);

        }*/

      } else {
        Get.snackbar("Error creating account", "enter all fields");
        return false;
      }
    } catch (e) {
      Get.snackbar("error while uploading", e.toString());
      return false;
    }
  }
}
