import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final Function(FilterOptions) onPressed;

  const FilterButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => FilterSheet(onPressed: onPressed),
        );
      },
      child: Text('Filter'),
    );
  }
}

class FilterSheet extends StatefulWidget {
  final Function(FilterOptions) onPressed;

  const FilterSheet({required this.onPressed});

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  FilterOptions _filterOptions = FilterOptions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Options',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _filterOptions.title = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Report Type',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _filterOptions.reportType = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onPressed(_filterOptions);
              Navigator.pop(context);
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}

class FilterOptions {
  String? title;
  String? reportType;
}
