import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/widgets/priority_dropdown.dart';
import 'package:jw_projekt/pages/specialist/specialist_reports/widgets/report_item.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

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
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)),

          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width:1 ),
              borderRadius: const BorderRadius.all(Radius.circular(5)),

            ),
            child: Column(
              children: [

                Container(
                  decoration: const BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.all(Radius.circular(5)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(report.status!,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                        const SizedBox(width: 5,),
                        Icon(Icons.circle,size: 14,color: ValueColorMapper.statusToColorString(report.status!),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
                  child: Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                          width: 280.w,// or specify a fixed width
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  report.reportType ?? "error",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                                ),
                                Spacer(),
                                //Expanded(child: Spacer(flex: 1,)),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(width: 5,),
                                    Text(
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
                          SizedBox(width: 360.w/1.7,
                            child: Text(report.content ?? "error",overflow: TextOverflow.clip,maxLines: 1,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                          ),
                          Row(
                            children: [
                              report.caretaker == "notAssigned"
                                  ? const SizedBox()
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
                    var item = controller.state.reportFilteredList[index];
                    print(item.toString());
                    return ReportItem(item);
                  }, childCount: controller.state.reportFilteredList.length),
                ),
              ),
            ],
          ),
        ));
  }
}
