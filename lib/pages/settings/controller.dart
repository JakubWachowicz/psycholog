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
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../view/widgets/text_input_field.dart';

class SettingsController extends GetxController{


  final state = LoginState();
  SettingsController();

}