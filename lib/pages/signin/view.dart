import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../view/widgets/text_input_field.dart';
import 'controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninPage extends GetView<SigninConroller> {
   SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _builDropDow() {
      return Obx((){return DropdownButton<String>(
        value: controller.state.currentRole.value,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.green),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String? newRole) {

          controller.handleRoleChanged(newRole!);
        },
        items: controller.state.roles
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
        });}

    var emailInputField = TextInputField(
      controller: controller.emailController,
      labelText: 'email',
      icon: Icons.email_outlined,
      isObscured: false,
      errorMessage: 'Invalid email',

    );

    var passwordInputField = TextInputField(
      controller: controller.passwordController,
      labelText: 'password',
      icon: Icons.lock,
      isObscured: true,
      errorMessage: 'Invalid password',

    );


    var nameInputField = TextInputField(
      controller: controller.nameController,
      labelText: 'name',
      icon: Icons.person,
      isObscured: false,
      errorMessage: 'Invalid name',

    );

    Widget _buildTextInputs() {
      return Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: nameInputField,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: emailInputField,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: passwordInputField,
            ),
          )
        ],
      );
    }

    Widget _buildLogo() {
      return Container(
        width: 110.w,
        margin: EdgeInsets.only(top: 84.h),
        child: Column(
          children: [
            Container(
              width: 76.w,
              height: 76.w,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 76.w,
                    decoration: BoxDecoration(
                      color: buttonColor,
                    ),
                  )),
                  Positioned(
                      child: Image.asset(
                    "assets/logo.jpg",
                    width: 76.w,
                    height: 76.w,
                    fit: BoxFit.cover,
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              child: Text(
                "SchoolCare",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
              ),
            )
          ],
        ),
      );
    }


    Widget _buildCreateUserButton() {
      return InkWell(
        onTap: () => {
          controller.handleSignIn()
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



    return Scaffold(
        body: Column(
          children: [
            //_buildLogo(),
            SizedBox(height: 90.h,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Create new account",style: TextStyle(fontSize: 32), textAlign: TextAlign.left,),
            ),
            _buildTextInputs(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 10.w,),
                  Text("Role: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey),),
                  SizedBox(width: 10.w,),
                  _builDropDow(),
                ],
              ),
            ),
            _buildCreateUserButton(),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      controller.hangleLogout();
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            )
          ],
        ));
  }
}
