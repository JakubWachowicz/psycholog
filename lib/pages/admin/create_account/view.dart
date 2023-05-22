 import 'package:jw_projekt/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../signin/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'index.dart';
import 'student_form/index.dart';

class CreateAccountPage extends GetView<CreateAccountConroller> {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildPageView() {
      return Expanded(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: controller.handlePageChanged,
          children: [
            StudentFormPage(),
            Center(child: Text('2'),),
            Center(child: Text('3'),),
          ],
        ),
      );
    }



      Widget _builDropDow() {
        return Obx((){return DropdownButton<String>(
          value: controller.state.currentRole.value,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.green,
          ),
          onChanged: (String? newRole) {
            controller.handleRoleChanged(newRole!);
          },
          items: controller.roles
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
        });}


    return Scaffold(
        body: Center(

          child: Container(alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [


                  SizedBox(height: 70.h,),
                  Text('Account type',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp,color: Colors.green),),
                  _builDropDow(),
                  _buildPageView()

                ],
              ),
            ),
          ),
        ),


    );
  }
}
