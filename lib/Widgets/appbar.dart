import 'package:flutter/material.dart';

AppBar studentAppBar(title){
  return AppBar(
    backgroundColor: Colors.transparent,
    bottomOpacity: 0.0,
    iconTheme: IconThemeData(
        color: Colors.black54
    ),
    elevation: 0.0,
    title: Text( title,style: TextStyle(color: Colors.black54),),


  );
}