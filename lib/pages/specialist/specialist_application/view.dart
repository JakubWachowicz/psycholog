 import 'package:jw_projekt/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/index.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

import '../../../Widgets/nav_bar.dart';
import '../../admin/admin_settings/index.dart';
import '../../signin/view.dart';

import '../specialist_messages/index.dart';
import '../specialist_report_kanban/index.dart';
import '../specialist_report_kanban/view.dart';
import 'index.dart';

class SpecialistApplicationPage extends GetView<SpecialistApplicationConroller> {
  const SpecialistApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPageView() {
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: [
          SpecialistMessagePage(),
          SpecialistReportsPage(),
          SpecialistReportKanbanPage(),
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
              selectedItemColor: SpecialistStyles.primaryColor,
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
