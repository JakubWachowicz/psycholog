import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:firebase_auth/firebase_auth.dart' as authP;

import '../../../controller/db_data_controller.dart';
import '../../../entities/messages.dart';
import '../../../entities/msg_content.dart';
import '../../../entities/user.dart';
import 'index.dart';

class ProfileConroller extends GetxController {
  ProfileConroller();

  final ProfileState state = ProfileState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  final dbController = DbDataController();
  late UserData user;
  late Rx<String> image = "assets/logo.jpg".obs ;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  Future<void> onInit() async {
    image.value =await dbController.getPhoto();
    image.refresh();
    super.onInit();
    user = dbController.getUSerData();
  }






}
