import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/widgets/priority_dropdown.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_item.dart';


import '../../../../Utils/date.dart';
import '../../../../entities/report.dart';
import '../controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourReportList extends GetView<YourReportsConroller> {
  const YourReportList({Key? key}) : super(key: key);



  Widget YourReportItem(Report report) {
    return InkWell(
      onTap: () =>{controller.goReport(report)},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
             color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [

                  Container(
              width: 270.w,
                    child: Row(

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          report.reportType ?? "error",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                          overflow: TextOverflow.clip,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 5,),
                            Text( overflow: TextOverflow.clip,
                              fullDateFormat(
                                report.timestamp!.toDate(),

                              ),style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),

                  Container(width: 260.w,
                    child: Text(report.title ?? "error",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp)),
                  ),
                  Container(width: 360.w/1.7,
                    child: Text(report.content ?? "error",overflow: TextOverflow.clip,maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp,)),
                  ),
                  Row(children: [
                    Text(report.status!),
                    SizedBox(width: 5,),
                    Icon(Icons.circle,size: 14,color: ValueColorMapper.statusToColorString(report.status!),)
                  ],)
                ],
              ),

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
      color: Colors.white,
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
                return YourReportItem(item);
              }, childCount: controller.state.reportList.length),
            ),
          ),
        ],
      ),
    ));
  }
}
