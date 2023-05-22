 import 'package:jw_projekt/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../signin/view.dart';

import '../admin_settings/index.dart';
import '../create_account/index.dart';
import 'index.dart';

class AdminApplicationPage extends GetView<AdminApplicationConroller> {
  const AdminApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPageView() {
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: [
          CreateAccountPage(),
          AdminSettingsPage(),
          Center(child: Text('Test'),),
          Center(child: Text('Test'),),
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
