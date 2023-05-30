import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jw_projekt/pages/student/your_reports/widgets/your_reports_list.dart';
import 'controller.dart';

class YourReportsPage extends GetView<YourReportsConroller> {
  const YourReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {







    return Scaffold(

      body: Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: YourReportList(),),
          ));
  }
}
