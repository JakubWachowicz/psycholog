 import 'package:jw_projekt/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../signin/view.dart';
import '../contact/view.dart';
import '../messages/view.dart';
import '../report/view.dart';
import 'index.dart';

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
