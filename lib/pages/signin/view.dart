import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/login/controller.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../view/widgets/text_input_field.dart';
import 'controller.dart';

class SigninPage extends GetView<SigninConroller> {
   SigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _builDropDow() {
      return Obx((){return DropdownButton<String>(
        value: controller.state.currentRole.value,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
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

          Container(
            child: nameInputField,
          ),

          Container(
            child: emailInputField,
          ),
          Container(
            child: passwordInputField,
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

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          _buildLogo(),
          _buildTextInputs(),
          _builDropDow(),
          ElevatedButton(
              onPressed: () {
                controller.handleSignIn();
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white70),
              )),

          ElevatedButton(
              onPressed: () {
                controller.hangleLogout();
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white70),
              ))
        ],
      ),
    ));
  }
}
