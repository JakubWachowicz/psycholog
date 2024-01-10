import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/student/report/widgets/report_category.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

import '../../../Widgets/nav_bar.dart';
import '../../../Widgets/student_appbar.dart';
import '../your_reports/index.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportPage extends GetView<ReportConroller> {
  const ReportPage({Key? key}) : super(key: key);



  Widget _buildTopMenuItem(String title,int itemIndex){
    return Obx(()=>Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: controller.state.index != itemIndex?Colors.white:Colors.green,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [SpecialistStyles.boxShadow],
        ),
        child: Text(title,style: TextStyle(color: controller.state.index != itemIndex?Colors.green:Colors.white,fontSize: 18),),
      ),
    ));
  }



  @override
  Widget build(BuildContext context) {
    Widget _buildTopMenu() {
      return Container(
        alignment: Alignment.topCenter,
        width: 360.w,
        color: Colors.white,
        child: Column(
          children: [
            //SizedBox(height: 35.w,child: Container(color: Colors.green,),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () => controller.state.index.value = 0,
                    child: _buildTopMenuItem("Wyślij zgłoszenie",0),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: InkWell(
                    onTap: () => controller.state.index.value = 1,
                    child: _buildTopMenuItem("Twoje zgłoszenia",1),
                  ),
                ),

              ],
            ),
            Obx(() => Container(
              child: controller.state.index.value == 0
                ? Expanded(child: ReportCategoryList())
                : Expanded(child:YourReportsPage())),
            )
          ],
        ),
      );
    }



    StudentAppBar _buildAppBar(){
      return StudentAppBar(title:"Zgłoszenia");
    }

    return Scaffold(
      drawer: NavBar(),
       appBar: _buildAppBar(),
        body: _buildTopMenu(),
    );
  }
}
