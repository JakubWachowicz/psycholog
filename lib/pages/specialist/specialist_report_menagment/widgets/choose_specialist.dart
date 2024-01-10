import 'package:flutter/material.dart';
import 'package:jw_projekt/Widgets/user_avatar.dart';

import '../../../../entities/user.dart';
import '../../../../styles/specialist_styles.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dummy{
  UserData user;
  Dummy(this.user);
}

class Choode_Specialist extends StatefulWidget {
  Choode_Specialist({super.key,required this.reportId});

  @override
  State<Choode_Specialist> createState() => _Choode_SpecialistState();
  var listener;
  late RxList specialists = [].obs;
  var reportId;
}

class _Choode_SpecialistState extends State<Choode_Specialist> {
  final db = FirebaseFirestore.instance;

  Future<void> updateCaretaker(String reportId, String caretaker) async {
    try {
      final reportRef =
      FirebaseFirestore.instance.collection('reports').doc(reportId);

      await reportRef.update({'caretaker': caretaker});

      print('Caretaker updated successfully');
    } catch (e) {
      print('Error updating caretaker: $e');
    }
  }



  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Choose caretaker"),
      backgroundColor: SpecialistStyles.primaryColor,
    );
  }

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
          updateCaretaker(widget.reportId,user.id!);
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
                child: Icon(Icons.attachment_rounded),
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

