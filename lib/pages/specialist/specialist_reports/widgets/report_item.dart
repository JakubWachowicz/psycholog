import 'package:flutter/material.dart';

import '../../../../Utils/date.dart';
import '../../../../entities/report.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ReportItem(Report report) {
  return InkWell(
    onTap: (){},
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
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
                Text(report.content ?? "error",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(report.priority.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.w,),
                    Text(
                      duTimeLineFormat(
                        report.timestamp!.toDate(),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
