import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_projekt/pages/report/state.dart';

import 'package:jw_projekt/pages/signin/state.dart';

import '../../common/routes/routes.dart';
import '../../controller/auth_controller.dart';

enum ReportTypes{
  SchoolViolence,
  DomesticViolence,
  Custom,
}

class ReportConroller extends GetxController{


  final state = ReportState();
  ReportConroller();



  goForm(ReportTypes reportType){
    Get.toNamed("/reportForm");
  }

}