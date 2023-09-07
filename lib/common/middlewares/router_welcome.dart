import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/common/stores/config.dart';

import '../../entities/user.dart';
import '../stores/user.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
class RouteWelcomeMiddleware extends GetMiddleware{

  @override
  int? priority = 0;

  final  dataConroller = DbDataController();

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route){


    print(ConfigStore.to.isFirstOpen);

    if(ConfigStore.to.isFirstOpen == false){
      return null;
    }
    else if(UserStore.to.isLogin == true){

        if(UserStore.to.role == "admin"){
          return const RouteSettings(name:AppRoutes.AdminApplication);
        }
        else if (UserStore.to.role == "specialist"){
          return RouteSettings(name:AppRoutes.SpecialistApplication);
        }
        else{
          return const RouteSettings(name:AppRoutes.Application);
        }

    }
    else{
      return const RouteSettings(name:AppRoutes.Login);
    }


  }

}