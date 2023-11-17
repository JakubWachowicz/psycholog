import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../Widgets/logo.dart';
import '../../view/widgets/text_input_field.dart';

class LoginPage extends GetView<LoginConroller> {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildTextInputs(){
      return Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: controller.emailInputField,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: controller.passwordInputField,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Container(
              width: 600.h,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IgnorePointer(
                ignoring: !controller.state.areAllFieldsEntered.value,
                child: Container(
                  foregroundDecoration: !controller.state.areAllFieldsEntered.value
                      ? BoxDecoration( //this can make disabled effect
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.lighten)
                      : null,
                  child: InkWell(
                      onTap: () {
                          controller.handleLogin();
                      },
                      child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.w700),
                          ))),
                ),
              ),
            ),
          )


        ],
      );
    }


    Widget _buildLogo() {


      return AnimatedOpacity(
        opacity: !controller.state.isKeyboardActive.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: 200.w,
          margin: EdgeInsets.only(top: 0.h),
          child:  !controller.state.isKeyboardActive.value?Column(
            children: [
              Container(
                width: 250.w,
                height: 250.w,

                child: Container(
                  width: 250.h,
                  height: 250.h,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/logo.jpg"),
                        fit: BoxFit.cover ,
                      )),
                ),
              ),


            ],
          ):null,

        )
      );
    }

    return Obx(()=>Scaffold(

        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(height: 90.w,),
               _buildLogo(),
                controller.state.errorMessage.value != ""?Text(controller.state.errorMessage.value,style: TextStyle(color: Colors.red)): Text(""),
                _buildTextInputs(),
              ]
          ),
        )));
  }
}
