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

class ReportFormPage extends GetView<ReportFormConroller> {
  const ReportFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    Widget _buildTitleEditor(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller.reportTitle,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "Enter report title"
          ),

        ),
      );
    }
    Widget _buildContentEditor(){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          minLines: 3,
          maxLines: 10,
          controller: controller.reportContent,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),

            ),
            hintText: 'Enter rapport content'
          ),
        ),
      );
    }

    Widget _buildSubmitButton(){
      return InkWell(
        onTap: () => {
          controller.sendReportToFirebase(controller.reportTitle.text,controller.reportContent.text)
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.w)), color: Colors.green,
          ),
          width: double.infinity,
          height: 60.w,

          child: Center(child: Text("Message me",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),)),
        ),

      );
    }


    return Scaffold(

      appBar: AppBar(title: Text( controller.reportType,
        overflow: TextOverflow.clip,
        maxLines: 1,),
        backgroundColor: Colors.green,

      ),

        body: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,


        children: [
          Text('Report Title'),
          _buildTitleEditor(),
          Text('Report Content'),
          _buildContentEditor(),
          _buildSubmitButton()

        ],
      ),
    );
  }
}
