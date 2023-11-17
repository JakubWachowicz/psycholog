import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/widgets/priority_dropdown.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_item.dart';

import '../../../../Utils/date.dart';
import '../../../../Widgets/caretaker_widget.dart';
import '../../../../entities/report.dart';
import '../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportList extends GetView<SpecialistReportsConroller> {
  const ReportList({Key? key}) : super(key: key);

  Widget ReportItem(Report report) {
    return InkWell(
      onTap: () =>{controller.goReport(report)},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)),

          child: Column(
            children: [
              Padding(
                padding:EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          report.reportType ?? "error",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                        Text(report.title ?? "error",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp)),
                        Container(width: 360.w/1.7,
                          child: Text(report.content ?? "error",overflow: TextOverflow.clip,maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                        ),
                        Row(
                          children: [
                            report.caretaker == "notAssigned"
                                ? SizedBox()
                                : FutureBuilder(
                              future: controller.getProfile(report.caretaker!),
                              builder: (BuildContext context,  snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  );
                                }
                                else{
                                  return buildCaretakerWidget(snapshot.data!);
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Text("Priority: " +  report.priority.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.w,),
                            Text(
                              duTimeLineFormat(
                                report.timestamp!.toDate(),
                              ),
                            ),




                          ],
                        ),

                      ),

                    ),

                  ],
                ),
              ),
              Container(
                width: 360.w,

                color: ValueColorMapper.priorityToColorString(report.priority!),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(report.priority!),
                ),)
            ],

          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      alignment: Alignment.topCenter,
      color: CupertinoColors.lightBackgroundGray,
          padding: EdgeInsets.only(top: 10.h),
          child: CustomScrollView(
            reverse: false,
            controller: controller.reportScrolling,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var item = controller.state.reportList[index];
                    print(item.toString());
                    return ReportItem(item);
                  }, childCount: controller.state.reportList.length),
                ),
              ),
            ],
          ),
        ));
  }
}
