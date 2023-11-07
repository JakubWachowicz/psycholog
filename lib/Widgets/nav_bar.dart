import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
import 'package:jw_projekt/controller/profile_data_controller.dart';

import '../common/routes/routes.dart';
import '../common/stores/user.dart';
import '../entities/user.dart';

class NavBar extends StatelessWidget {
  DbDataController dbDataController = DbDataController();
  Rx<String> name = "Name".obs;

  void updateName() async {

    name.value = (await dbDataController.getName())!;

  }

  @override
  Widget build(BuildContext context) {
    updateName();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Obx(() => Text(
             name.value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            accountEmail: Text(
              UserStore.to.role == "student" ? "Student" : "Specialist",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  ProfileDataController.profileAvatar.value,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: AssetImage('assets/navBarImage.jpg'),
                    fit: BoxFit
                        .fill) // Customize the header background color here
                ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {

              UserStore.to.role == "student" ? Get.offAndToNamed(AppRoutes.Profile): Get.offAndToNamed(AppRoutes.SpecialistProfile);



            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: (){
                Get.offAndToNamed(AppRoutes.Settings);
            },
          ),
          const ListTile(
            leading: Icon(Icons.document_scanner),
            title: Text('Policies'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              try {
                UserStore.to.onLogout();

                Get.offAllNamed(AppRoutes.Login);

              } catch (e) {}
            },
          ),
        ],
      ),
    );
  }
}
