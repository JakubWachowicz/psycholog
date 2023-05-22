import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/stores/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/routes/routes.dart';
import 'index.dart';

class ReportFormConroller extends GetxController{


  final state = ReportFormState();
  ReportFormConroller();
  TextEditingController reportContent = TextEditingController();
  TextEditingController reportTitle = TextEditingController();

  final user_id = UserStore.to.token;

  late final reportType;
  Future<void> sendReportToFirebase(String title, String content) async {
    try {
      await FirebaseFirestore.instance.collection('reports').add({
        'title': title,
        'reportType': reportType,
        'content': content,
        'status' : 'notAssigned',
        'studentId' : user_id,
        'caretaker' : "notAssigned",
        'priority' : "notAssigned",
        'timestamp': DateTime.now(),
      });
      print('Report sent to Firebase successfully');


      Get.offAndToNamed(AppRoutes.Application);
      Get.snackbar(
        'Success',
        'Report sent successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Error sending report to Firebase: $e');

      // Show error pop-up message
      Get.snackbar(
        'Error',
        'Failed to send report. Please try again later.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );



    } catch (e) {
      print('Error sending report to Firebase: $e');
    }
  }



  @override
  void onInit() {
    super.onInit();

    var data = Get.parameters;
    reportType = data['reportType'];

  }



}