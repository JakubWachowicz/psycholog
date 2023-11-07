import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.child, required this.icon});
  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5,bottom: 5),
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.w),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
          children: [
            SizedBox(width: 10,),
            Icon(icon,size: 30,),
            SizedBox(width: 10,),
            child,
          ],
      ),
    );
  }
}
