import 'package:flutter/material.dart';
class StudentAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
   StudentAppBar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title,style: TextStyle(color: Colors.black54),),
      backgroundColor: Colors.white,
      iconTheme:  IconThemeData(
        color: Colors.green,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
