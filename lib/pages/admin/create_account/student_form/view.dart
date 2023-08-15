import 'package:jw_projekt/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view/widgets/text_input_field.dart';
import 'index.dart';
import 'package:dots_indicator/dots_indicator.dart';

class StudentFormPage extends GetView<StudentFormConroller> {
  StudentFormPage({Key? key}) : super(key: key);
  Rx<bool> isPasswordValid = true.obs;

  @override
  Widget build(BuildContext context) {
    var peselInputField = TextInputField(
      controller: controller.peselController,
      labelText: 'PESEL',
      icon: Icons.email_outlined,
      isObscured: false,
      errorMessage: 'Invalid PESEL',
    );

    Widget _buildSubmitButton() {
      return InkWell(
        onTap: () => {
          controller.handlePeselSubmit(),
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: Colors.green,
          ),
          width: double.infinity,
          height: 60.w,
          child: Center(
              child: Text(
            "Create account",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          )),
        ),
      );
    }

    Widget _buildPage2() {
      return Obx(() => Container(
            child: Column(
              children: [
                Text(controller.peselController.text),
                Text(controller.state.password.value),
              ],
            ),
          ));
    }

    Widget _buildPage3() {
      return Container();
    }

    Widget _buildPeselInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student account',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Colors.green),
          ),
          SizedBox(
            height: 30.w,
          ),
          peselInputField
        ],
      );
    }

    Widget _buildPage1() {
      return Container(
        child: Column(
          children: [
            _buildPeselInput(),
            SizedBox(
              height: 40.w,
            ),
            _buildSubmitButton(),
          ],
        ),
      );
    }

    Widget _buildForm() {
      return Expanded(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: controller.handlePageChanged,
          children: [
            _buildPage1(),
            _buildPage2(),
            Center(
              child: Text('3'),
            ),
          ],
        ),
      );
    }

    Widget _buildDotsIndicator() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          child: DotsIndicator(
            decorator: DotsDecorator(
                activeColor: Colors.green,
                size: Size.square(13),
                activeSize: Size(30.0, 13.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            position: controller.state.index.toDouble(),
            dotsCount: 3,
            reversed: false,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                _buildForm(),
                _buildDotsIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
