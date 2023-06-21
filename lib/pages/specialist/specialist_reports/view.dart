import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_filter.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_list.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: Colors.green,
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SortReportsButton(onPressed: (SortReportsBy sortby) {controller.sortReports(sortby); },),
            ),
          ),
        ],

      );
    }

    return Scaffold(

        drawer: NavBar(),
        appBar: _buildAppBar(),
        body: Container(

            alignment: Alignment.center,
            child: Column(
              children: [

                Expanded(child: Center(child: ReportList())),
              ],
            )));
  }
}
