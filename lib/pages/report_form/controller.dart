import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/pages/report_form/state.dart';

import 'package:jw_projekt/pages/signin/state.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';


class ReportFormConroller extends GetxController{


  final state = ReportFormState();
  ReportFormConroller();
  TextEditingController reportContent = TextEditingController();





}