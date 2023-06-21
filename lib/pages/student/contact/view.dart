
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/pages/student/contact/widgets/contact_list.dart';
import '../../../Widgets/nav_bar.dart';
import 'controller.dart';

class ContactPage extends GetView<ContactConroller> {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Messages"),
        backgroundColor: Colors.green,
      );
    }

    print(controller.state.messageList.length);
    return Scaffold(

        appBar: _buildAppBar(),
        drawer: NavBar(),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: ContactList()),
        ));
  }
}
