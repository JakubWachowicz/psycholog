import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class SpecialistApplicationConroller extends GetxController{

  final state = SpecialistApplicationState();
  SpecialistApplicationConroller();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['Chat', 'Contact','Profile'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.message),label: 'messages'),

      const BottomNavigationBarItem(icon: Icon(Icons.error),label: 'reports'),
      const BottomNavigationBarItem(icon: Icon(Icons.error_sharp), label: 'report board'),




    ];
    pageController = PageController(initialPage:state.page);


  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  handlePageChanged(int index) {
    state.page = index;
  }

  void handleNavBarTap(int index){
    pageController.jumpToPage(index);

  }



}