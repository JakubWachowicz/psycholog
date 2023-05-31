import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'controller.dart';

class ReportFormPage extends GetView<ReportFormConroller> {
  const ReportFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildTitleEditor() {
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
    Widget _buildContentEditor() {
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

    Widget _buildSubmitButton() {
      return InkWell(
        onTap: () =>
        {
          controller.sendReportToFirebase(
              controller.reportTitle.text, controller.reportContent.text)
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: Colors.green,
          ),
          width: double.infinity,
          height: 60.w,

          child: Center(child: Text("Send report", style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),)),
        ),

      );
    }


    Widget _buildFullForm() {
      return
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height: 20.h,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text('Report Title', style: TextStyle(color: Colors.black,
                       fontSize: 22.sp,
                       fontWeight: FontWeight.bold),),
                 ),
                 _buildTitleEditor(),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text('Report Content', style: TextStyle(
                       color: Colors.black,
                       fontSize: 18.sp,
                       fontWeight: FontWeight.bold)),
                 ),
                 _buildContentEditor(),
                 SizedBox(height: 30.w,),
                 _buildSubmitButton()

               ],

        );
    }



    return Scaffold(

      appBar: AppBar(title: Text(controller.reportType,
        overflow: TextOverflow.clip,
        maxLines: 1,),
        backgroundColor: Colors.green,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.white,),
          onTap: () {
            Get.back();
          },
        ),


      ),

      body: SingleChildScrollView(child:_buildFullForm())
    );
  }
}
