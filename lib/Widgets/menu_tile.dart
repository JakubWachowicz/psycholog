import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.child, required this.icon,this.iconColor = Colors.black54});
  final Widget child;
  final IconData icon;
  final iconColor;

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
            Icon(icon,size: 30,color: iconColor,),
            SizedBox(width: 10,),
            child,
          ],
      ),
    );
  }
}
