import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

import '../../../Widgets/appbar.dart';



class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePage createState() => _ChangeNamePage();
}

class _ChangeNamePage extends State<ChangeNamePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();

  String _displayName = "";

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }

  Future<void> _loadDisplayName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _displayName = user.displayName ?? "";
      });
    }
  }

  Future<void> _updateDisplayName() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(_nameController.text.trim());
        await user.reload();
        user = _auth.currentUser; // Refresh the user object
        setState(() {
          _displayName = user!.displayName ?? "";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User name updated successfully.'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating user name: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: studentAppBar("Change display name"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Text(
              'Current User Name: $_displayName',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'New User Name'),

            ),
            SizedBox(height: 20),
            Container(

              child: ElevatedButton(
                style:  ElevatedButton.styleFrom(
                  primary: Colors.green, // Background color
                ),
                onPressed: _updateDisplayName,
                child: Text('Update User Name'),
              ),
            ),
            SizedBox(height: 80,)
          ],
        ),
      ),
    );
  }
}
