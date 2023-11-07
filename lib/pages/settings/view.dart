import 'package:jw_projekt/pages/settings/controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SettingsPage extends GetView<SettingsController> {
  SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Settings"),

      ),
     body: ListView(
       children: const [
         ListTile(title: Text("Change display name"),leading: Icon(Icons.person),),
         ListTile(title: Text("Change password"),leading: Icon(Icons.password),),
         ListTile(title: Text("Change PIN"),leading: Icon(Icons.lock),),
       ],
     ),
   );
  }
}
