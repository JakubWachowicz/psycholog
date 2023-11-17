import 'package:flutter/material.dart';
 class ValueColorMapper{
  static Color priorityToColor(Priority priority){
    switch(priority){
      case Priority.Critical:
        return Colors.red;
      case Priority.High:
        return Colors.orange;
      case Priority.Medium:
        return Colors.yellow;
      case Priority.Low:
        return Colors.grey;
    }
  }
}
 enum Priority{
  Critical,
  High,
  Medium,
  Low,
}