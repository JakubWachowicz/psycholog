 import 'package:jw_projekt/Utils/constants.dart';
import 'package:jw_projekt/pages/application/index.dart';
import 'package:jw_projekt/pages/welcome/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../view/screens/auth/signup_screen.dart';
import '../contact/view.dart';
import '../messages/view.dart';
import '../report/index.dart';
import '../signin/view.dart';

class ApplicationPage extends GetView<ApplicationConroller> {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPageView() {
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: [
          Center(
            child: MessagePage()
          ),
          Center(
            child: Container(
              child: SigninPage(),
            ),
          ),
          Center(
            child: Container(
              child: ContactPage(),
            ),
          ),
          Center(
            child: ReportPage(),
          ),
        ],
      );
    }

    Widget _buildBottomNavigationBar() {
      return Obx(
            () =>
            BottomNavigationBar(items: controller.bottomTabs,
                currentIndex: controller.state.page,
                type:BottomNavigationBarType.fixed,
                onTap: controller.handleNavBarTap,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedItemColor: borderColor,
              selectedItemColor: buttonColor,
            ),


      );
    }

    return Scaffold(

        body:
        _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),

    );
  }
}
