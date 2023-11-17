import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("BLOOM!",style: TextStyle(fontFamily: "Poppins",fontSize: 34.sp,fontWeight: FontWeight.w900,color: Colors.green),);
  }
}
