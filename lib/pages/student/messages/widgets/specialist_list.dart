import 'package:flutter/material.dart';
import 'package:jw_projekt/Widgets/user_avatar.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
import 'package:jw_projekt/controller/send_message_controller.dart';

import '../../../../entities/user.dart';
import '../../../../styles/specialist_styles.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dummy{
  UserData user;
  Dummy(this.user);
}

class Choose_Specialist extends StatefulWidget {
  Choose_Specialist({super.key});

  @override
  State<Choose_Specialist> createState() => _Choose_SpecialistState();
  var listener;
  late RxList specialists = [].obs;


}

class _Choose_SpecialistState extends State<Choose_Specialist> {
  final db = FirebaseFirestore.instance;



  Future<void>  goToChat(UserData to_userdata) async {
    DbDataController dataController = DbDataController();
    UserData? data = await dataController.fetchCurrentUser()!;
    dataController.goChat(data!, to_userdata, true  );
    print(to_userdata);

  }



  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black54
      ),
      title: const Text("Wybierz specialistę",style: TextStyle(color: Colors.black54),),
      backgroundColor: Colors.white,
    );}

  Future<List<UserData>> fetchSpecialists() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "specialist")
        .get();

    return querySnapshot.docs
        .map((doc) => UserData.fromFirestore(doc,null))
        .toList();
  }

  Widget buildItem(UserData user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          goToChat(user);
          Navigator.pop(context,user);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: SpecialistStyles.decoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Replace UserAvatarWidget with your implementation
              Container(
                child: Row(children: [ UserAvatarWidget(role: "specialist", path: user.photourl!, size: 54),
                  SizedBox(width: 16),
                  Text(user.name ?? '',style: TextStyle(overflow: TextOverflow.clip),),],),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.message),
              )


            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          color: SpecialistStyles.backgroundColor,
          child: FutureBuilder<List<UserData>>(
            future: fetchSpecialists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No specialists found.');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return buildItem(snapshot.data![index]);
                  },
                );
              }
            },
          ),
        ));
  }


}

