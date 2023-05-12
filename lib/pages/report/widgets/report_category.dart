import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ReportCategoryList extends GetView<ReportConroller> {
  Widget _buildCategory(String goTo, Icon icon) {
    return InkWell(
      onTap: () {
        controller.goForm(ReportTypes.Custom);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 150.w,
          height: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70,
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCategory("Test", Icon(Icons.person,)),
              _buildCategory("Test", Icon(Icons.person)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCategory("Test", Icon(Icons.person)),
              _buildCategory("Test", Icon(Icons.person)),
            ],
          ),
        ],
      ),
    );
  }
}
