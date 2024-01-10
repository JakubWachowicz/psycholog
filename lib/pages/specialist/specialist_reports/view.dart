import 'package:flutter/cupertino.dart';
import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_filter.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_list.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import '../../../Widgets/filter_reports.dart';
import '../../../Widgets/nav_bar.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpecialistReportsPage extends GetView<SpecialistReportsConroller> {
  const SpecialistReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Reports"),
        backgroundColor:    Color.fromRGBO(92, 129, 73, 1.0),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(onTap: () {controller.state.areFiltersOpen.value = !controller.state.areFiltersOpen.value;} ,child: Icon(Icons.sort),),
            ),
          ),
        ],

      );
    }

    return Scaffold(

        drawer: NavBar(),
        appBar: _buildAppBar(),
        body: Container(
              color: CupertinoColors.lightBackgroundGray,
            alignment: Alignment.center,
            child: Column(
              children: [
               FilterReports(filter:controller.filterReports,isOpened: controller.state.areFiltersOpen,) ,
                Expanded(child: Center(child: ReportList())),
              ],
            )));
  }
}
