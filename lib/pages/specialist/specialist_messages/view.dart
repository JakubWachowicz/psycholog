import 'package:flutter/cupertino.dart';
import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/search_wideg.dart';
import 'package:jw_projekt/pages/specialist/specialist_messages/widgets/sort_button.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import '../../../Widgets/nav_bar.dart';
import '../../student/messages/widgets/messages_list_new.dart';
import 'controller.dart';
import 'widgets/messages_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpecialistMessagePage extends GetView<SpecialistMessagesConroller> {
  const SpecialistMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Widget _buildSortButton(){
      return Container(

          child: SortButton(onPressed: (SortType sortType) {  controller.sortMessages(sortType);},));
    }

    AppBar _buildAppBar(){
      return AppBar(
        title: Text("Messages"),
        backgroundColor:  Color.fromRGBO(92, 129, 73, 1.0),
        actions: [
          InkWell(
            onTap: (){
              controller.state.isFilterOpen.value = !controller.state.isFilterOpen.value;
            },
            splashColor: Colors.grey,
            child: Container(

              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child:Icon(Icons.search),
              ),
            ),
          ),
        ],
      );
    }



    return Scaffold(
        drawer: NavBar(),
        appBar: _buildAppBar(),
        body: Container(
          color: SpecialistStyles.backgroundColor,
          child: Column(
            children: [

              Obx(()=>controller.state.isFilterOpen.value?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(child: Container(child: SearchWidget(searchController: controller.searchController,onSearch: controller.searchMessages,))),
                      SortButton(onPressed: (SortType sortType) {  controller.sortMessages(sortType);},),
                    ],
                  ),
                ),
              ):SizedBox(),),



              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpecialistMessageListNew(),
                ),
              ),
            ],
          ),
        ));
  }
}
