import 'package:flutter/material.dart';

class EditableTextWidget extends StatefulWidget {
  final String label;
  final String value;
  final List<String> options;
  final VoidCallback onEditPressed;

  EditableTextWidget({
    required this.label,
    required this.value,
    required this.options,
    required this.onEditPressed,
  });

  @override
  _EditableTextWidgetState createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late bool _isEditing;
  late String _editedValue;

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _editedValue = widget.value;
  }

  void _toggleEditing() {
    setState(() {
      if (_isEditing) {
        widget.onEditPressed(); // Trigger the edit action
        _isEditing = false;
      } else {
        _isEditing = true;
      }
    });
  }

  void _handleOptionSelected(String? selectedOption) {
    if (selectedOption != null) {
      setState(() {
        _editedValue = selectedOption;
      });
      widget.onEditPressed(); // Trigger the edit action when an option is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          _isEditing
              ? DropdownButton<String>(
            value: _editedValue,
            items: widget.options
                .map((option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ))
                .toList(),
            onChanged: _handleOptionSelected,
          )
              : Row(
            children: [
              Expanded(
                child: Text(
                  _editedValue,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: _toggleEditing,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
