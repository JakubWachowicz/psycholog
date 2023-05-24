import 'package:jw_projekt/common/stores/user.dart';
import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_filter.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_list.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_sort.dart';
import 'package:jw_projekt/pages/student/messages/widgets/messages_list.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/editable_text_widget.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpecialistReportsMenagmentPage extends GetView<SpecialistReportsMenagmentConroller> {
  const SpecialistReportsMenagmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    AppBar _buildAppBar(){
      return AppBar(
        title: Obx(()=>( Text(controller.state.title.value ?? ""))),
        backgroundColor: Colors.green,


      );
    }

    Widget _buildValueWidget(String label, RxString value) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 4.0),
            Obx(
                  () => Text(
                value.value,
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(

        appBar: _buildAppBar(),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildValueWidget('Report ID', controller.state.reportId),
            Row(
              children: [
                _buildValueWidget('Caretaker', controller.state.caretaker),
                InkWell(onTap: (){
                  controller.updateCaretaker(controller.report_id,UserStore.to.token??"error");
                },
                child: Icon(Icons.sync),)
              ],
            ),
            _buildValueWidget('Title', controller.state.title),
            _buildValueWidget('Content', controller.state.content),
            _buildValueWidget('Priority', controller.state.priority),
            _buildValueWidget('Report Type', controller.state.reportType),
            _buildValueWidget('Status', controller.state.status),
            _buildValueWidget('Timestamp', controller.state.timeStamp),


          ],
        ),
    );
  }
}
