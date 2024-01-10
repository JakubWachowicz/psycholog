import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jw_projekt/pages/student/YourReportInfo/widgets/commentList.dart';
import 'package:jw_projekt/pages/student/your_reports/widgets/your_reports_list.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

import '../../../Widgets/menu_tile.dart';
import '../../specialist/specialist_report_menagment/widgets/priority_dropdown.dart';
import 'controller.dart';


class YourReportInfoPage extends GetView<YourReportInfoConroller> {
  const YourReportInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        title: Obx(() => (Text(controller.state.title.value ?? ""))),
        backgroundColor: Colors.green,
      );
    }

    Widget _buildValueWidget(String label, RxString value) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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



    Widget _buildContent(RxString value){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 360.w,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  const Text('Report content: ',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 5.w,),
                Obx(
                      () => Text(
                    value.value,
                    maxLines: null,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }


    Widget _buildGoChatButton() {
      return InkWell(
        onTap: () {
          controller.goChat();
        },
        child: Container(
          alignment: Alignment.center,
          width: 360.w,
          height: 360.h / 7,
          margin: EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green),
          child: Text(
            "Go to chat",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }


    Widget _buildReportBody() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                      () => Expanded(
                        child: Text(
                          controller.state.title.value,
                          style: TextStyle(fontSize: 22.sp,color: Colors.green,fontWeight: FontWeight.bold),
                  ),
                      ),
                ),
                SizedBox(width: 20.w,),

                Container(child: _buildValueWidget('Timestamp', controller.state.timeStamp),alignment: Alignment.centerRight, ),
                Expanded(child: SizedBox(width: 360.w,)),

              ],
            ),

            Obx(
                  () => Text(
                    controller.state.reportType.value,
                style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Text("State: ", style: TextStyle(fontWeight: FontWeight.bold),),
                _buildValueWidget('Status', controller.state.status),
              ],
            ),

            SizedBox(height: 10.w,),
            _buildContent( controller.state.content),
            SizedBox(height: 10.w,),
            _buildGoChatButton()




          ],
        ),
      );
    }




    return Scaffold(
      appBar: _buildAppBar(),
      body:  Container(
        height: 360.w,
        color: SpecialistStyles.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(

    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(
                              () => Expanded(
                            child: Text(
                              controller.state.title.value,

                              style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),


                      ],
                    ),
                    Obx(
                          () => Row(
                        children: [
                          const Icon(Icons.info),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            controller.state.reportType.value,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MenuTile(child: Row(children: [
                Text("Date: "),
                Obx(()=>Text(controller.state.timeStamp.toString())),
              ],), icon:Icons.calendar_month ),

              MenuTile(child: Row(children: [
                Text("Status: "),
                Obx(()=>Text(controller.state.status.toString())),
              ],), icon:Icons.circle,iconColor: ValueColorMapper.statusToColorString(controller.state.status.toString(),),),

              SizedBox(
                height: 5.w,
              ),
              _buildContent(controller.state.content),
              SizedBox(
                height: 10.w,
              ),
              _buildGoChatButton()


            ],
    ),
    ),
          ),
        ),
      )
    );
  }
}
