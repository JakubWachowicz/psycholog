import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/common/routes/routes.dart';
import 'package:jw_projekt/common/stores/config.dart';

import '../stores/user.dart';

class RouteWelcomeMiddleware extends GetMiddleware{

  @override
  int? priority = 0;


  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route){


    print(ConfigStore.to.isFirstOpen);
    if(ConfigStore.to.isFirstOpen == false){
      return null;
    }
    else if(UserStore.to.isLogin == true){
      return const RouteSettings(name:AppRoutes.Application);
    }
    else{
      return const RouteSettings(name:AppRoutes.Login);
    }


  }

}