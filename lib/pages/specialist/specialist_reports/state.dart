import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../entities/messages.dart';
import '../../../entities/report.dart';
class SpecialistReportsState{

  //RxList<QueryDocumentSnapshot<Report>> reportList = <QueryDocumentSnapshot<Report>>[].obs;
  RxList<Report> reportList = <Report>[].obs;

}