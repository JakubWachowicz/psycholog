import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ReportCategoryList extends GetView<ReportConroller> {
  Widget _buildCategory(String goTo, Icon icon) {
    return InkWell(
      onTap: () {
        controller.goForm(goTo);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150.w,
          height: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconTheme(
                data: IconThemeData(size: 70.sp),
                child: icon,
              ),
              Text(goTo),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*Container(
            alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Select report category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.sp,color: Colors.green),),
              )),*/
          SizedBox(height: 30.w,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCategory("Domestic violence", Icon(Icons.person,)),
              _buildCategory("School violence", Icon(Icons.person)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCategory("Problems in school", Icon(Icons.person)),
              _buildCategory("Others", Icon(Icons.person)),
            ],
          ),
        ],
      ),
    );
  }
}
