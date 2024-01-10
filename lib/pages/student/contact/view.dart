
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
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        //title: Text( "Nasi specialiści", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Colors.green),),
        leading: Builder(
          builder:(context){

            return IconButton(
              icon: Icon(Icons.menu,color: Colors.black,),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }

        ),

      );
    }

    print(controller.state.messageList.length);
    return Scaffold(

        //appBar: _buildAppBar(),
        drawer: NavBar(),

        body: Center(child: ContactList()));
  }
}
