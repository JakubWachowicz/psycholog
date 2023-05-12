import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/report/widgets/report_category.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../view/widgets/text_input_field.dart';
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
