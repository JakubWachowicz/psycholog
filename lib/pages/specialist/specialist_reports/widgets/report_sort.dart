import 'package:flutter/material.dart';

enum SortReportsBy {
  Title,
  Priority,
  Timestamp,
}

class SortReportsButton extends StatelessWidget {
  final Function(SortReportsBy) onPressed;

  const SortReportsButton({required this.onPressed});



  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortReportsBy>(
      onSelected: onPressed,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SortReportsBy>>[
        PopupMenuItem<SortReportsBy>(
          value: SortReportsBy.Title,
          child: Text('Sort by Title'),
        ),
        PopupMenuItem<SortReportsBy>(
          value: SortReportsBy.Priority,
          child: Text('Sort by Priority'),
        ),
        PopupMenuItem<SortReportsBy>(
          value: SortReportsBy.Timestamp,
          child: Text('Sort by Timestamp'),
        ),
      ],
      child: InkWell(

        child: Container(

            child: Icon(Icons.sort)),
      ),
    );
  }
}
