import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class SpecialistStyles {
  static const Color primaryColor =   Color.fromRGBO(92, 129, 73, 1.0);
  static const Color backgroundColor = CupertinoColors.extraLightBackgroundGray;
  static   BoxShadow boxShadow =BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 3,
    blurRadius: 5,
    offset: Offset(0, 3), // changes position of shadow
  );
  static BoxDecoration decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 5,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}
