import 'package:flutter/material.dart';
import 'package:jw_projekt/entities/report.dart';

class UserAvatarWidget extends StatelessWidget{

  late String role;
  late String path;
  late double size;
  UserAvatarWidget({required this.role,required this.path,required this.size});

  @override
  Widget build(BuildContext context) {
    return
      role == 'student'?
      Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image:AssetImage(path),
        ),
      ),
    ): Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
        fit: BoxFit.cover,
        image:NetworkImage(path),
    ),
    ));
  }
}