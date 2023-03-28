import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:jw_projekt/model/user.dart' as model;

import '../Utils/constants.dart';
import '../Utils/routes_util.dart';

class AuthenticationClontroller extends GetxController{


  late Rx<User?> _user;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
  }

  static AuthenticationClontroller instance = Get.find();

  Future<bool> registerUser(String firstName, String lastName, String email, String password, String pesel) async {
    try{
      if(firstName.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty && password.isNotEmpty && pesel.isNotEmpty){
        var cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        model.User user = model.User(firstName: firstName, lastName: lastName, email: email, uid: cred.user!.uid, pesel: pesel);
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
        print('userCreated');
        Get.snackbar("Creating account succeed", "you are ready to login!");
      }else{
        Get.snackbar("Error creating account", "enter all fields");}
      return false;
    }catch(e){
      Get.snackbar("Error", e.toString());
      return false;
    }
    return true;
  }

  void loginUser(String email,String password) async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print('login succesed');
        Get.toNamed(RoutesUtil.getHomeRoute());
      }else{
        Get.snackbar("Error creating account", "enter all fields");}
    }catch(e){
      Get.snackbar("error while uploading", e.toString());
    }
  }
}
