import 'package:flutter/material.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
import 'package:jw_projekt/entities/report.dart';

class UserAvatarWidget extends StatelessWidget{

  late String role;
  late String path;
  late double size;




  UserAvatarWidget({required this.role,required this.path,required this.size}){
    if(path == "testPhoto"){
      path = "assets/logo.jpg";
    }

  }

  @override
  Widget build(BuildContext context) {
    return

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
    );
  }
}