import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/student/report/widgets/report_category.dart';

import 'controller.dart';

class ReportPage extends GetView<ReportConroller> {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,


        children: [
          ReportCategoryList()
        ],
      ),
    );
  }
}
