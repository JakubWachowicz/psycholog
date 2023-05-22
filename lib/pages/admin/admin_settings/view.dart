import 'package:jw_projekt/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/common/stores/user.dart';

import '../../signin/view.dart';

import '../create_account/index.dart';
import 'index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminSettingsPage extends GetView<AdminSettingsController> {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 200.h,),
            InkWell(

              onTap: controller.hangleLogout,
              child: Container(
              alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app_sharp),
                    Text("Logout"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
