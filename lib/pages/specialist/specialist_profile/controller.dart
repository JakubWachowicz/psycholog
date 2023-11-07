import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/controller/specialist_db_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:firebase_auth/firebase_auth.dart' as authP;

import '../../../controller/db_data_controller.dart';
import '../../../entities/messages.dart';
import '../../../entities/msg_content.dart';
import '../../../entities/user.dart';
import 'index.dart';

class SpecialistProfileConroller extends GetxController {
  SpecialistProfileConroller();

  final SpecialistProfileState state = SpecialistProfileState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;
  final dbController = DbDataController();
  late UserData user;
  late Rx<String> image = "assets/logo.jpg".obs ;
  late final specialistDbController;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  Future<void> onInit() async {
    specialistDbController = SpecialistDbController(token);
    image.value =await dbController.getPhoto();
    image.refresh();
    super.onInit();
    //user = dbController.getUSerData();
    state.description.value = await specialistDbController.getDescritpion();

  }








}
