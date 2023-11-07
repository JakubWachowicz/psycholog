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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),

          ),

            child: Icon(Icons.sort)
        ),
      ),
    );
  }
}

enum SortType {
  timestamp,
  alphabetical,
}
