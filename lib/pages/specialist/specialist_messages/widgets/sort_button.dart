import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortButton extends StatelessWidget {
  final Function(SortType) onPressed;

  SortButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortType>(
      onSelected: onPressed,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<SortType>>[
          const PopupMenuItem<SortType>(
            value: SortType.timestamp,
            child: Text('Sort by Timestamp'),
          ),
          const PopupMenuItem<SortType>(
            value: SortType.alphabetical,
            child: Text('Sort Alphabetically'),
          ),
        ];
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.green,  // Change border color here

          ),
        ),

          child: Icon(Icons.sort)
      ),
    );
  }
}

enum SortType {
  timestamp,
  alphabetical,
}
