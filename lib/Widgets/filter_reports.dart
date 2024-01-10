import 'package:flutter/material.dart';
import 'package:jw_projekt/Widgets/user_avatar.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import 'package:get/get.dart';
import '../common/stores/user.dart';
import '../entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


enum FilterType{
  Date,
  Status,
  Priority,
}
class FilterReports extends StatefulWidget {

  final Function(String date,String priority,String status,String caretaker) filter;
   FilterReports({super.key,required this.filter,required this.isOpened});
  Rx<bool> isOpened;
  @override
  State<FilterReports> createState() => _FilterReportsState();
  late List<UserData> specialists;
  final user_id = UserStore.to.token;



   Future<List<UserData>> fetchSpecialists() async {

     List<UserData> result;
     var querySnapshot = await FirebaseFirestore.instance
         .collection("users")
         .where("role", isEqualTo: "specialist").where("id",isEqualTo: user_id)
         .get();

     result = querySnapshot.docs
         .map((doc) => UserData.fromFirestore(doc,null))
         .toList();


      querySnapshot = await FirebaseFirestore.instance
         .collection("users")
         .where("role", isEqualTo: "specialist").where("id",isNotEqualTo: user_id)
         .get();

     result.addAll(querySnapshot.docs
         .map((doc) => UserData.fromFirestore(doc,null))
         .toList());

     print(result);
     return result;

   }

   // Variables to hold currently selected values
   Rx<String> selectedDate = "".obs;
   Rx<String> selectedPriority = "".obs;
   Rx<String> selectedStatus = "".obs;
   Rx<String> selectedCaretaker = "".obs;


}

class _FilterReportsState extends State<FilterReports> {

  buildFilterLabel(String filterName){
    return Container(
        margin: EdgeInsets.only(left: 8,top: 8),
        child: Text(filterName,style: TextStyle(fontWeight: FontWeight.w600),));
  }


  initSpecialists() async {
    widget.specialists = await widget.fetchSpecialists();
  }




  buildPriorityEntry(String priority){
    return Obx(()=>GestureDetector(
        onTap: (){
          if(widget.selectedPriority.value == priority){
            widget.selectedPriority.value = "";
          }else{
            widget.selectedPriority.value = priority;
          }


          widget.filter(widget.selectedDate.value,widget.selectedPriority.value,widget.selectedStatus.value,widget.selectedCaretaker.value);
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [SpecialistStyles.boxShadow],
              color: priority == widget.selectedPriority.value ? SpecialistStyles.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: priority == widget.selectedPriority.value ? SpecialistStyles.primaryColor : Colors.white,
              ),
            ),
            margin:  const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(priority,style: TextStyle(color:  priority== widget.selectedPriority.value ? Colors.white: Colors.black),)
                ],
              ),
            ))
    ));
  }
  buildPriorityFilter(){
    return  Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildPriorityEntry("Priority.Critical"),
            buildPriorityEntry("Priority.High"),
            buildPriorityEntry("Priority.Medium"),
            buildPriorityEntry("Priority.Low"),
          ],
        ),
      ),
    );
  }



  buildStatusEntry(String status){
    return Obx(()=>GestureDetector(
        onTap: (){
          if(widget.selectedStatus.value == status){
            widget.selectedStatus.value = "";
          }else{
            widget.selectedStatus.value = status;
          }
          widget.filter(widget.selectedDate.value,widget.selectedPriority.value,widget.selectedStatus.value,widget.selectedCaretaker.value);
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [SpecialistStyles.boxShadow],
              color: status == widget.selectedStatus.value ? SpecialistStyles.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: status == widget.selectedStatus.value ? SpecialistStyles.primaryColor : Colors.white,
              ),
            ),
            margin:  const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(status,style: TextStyle(color:  status== widget.selectedStatus.value ? Colors.white: Colors.black),)
                ],
              ),
            ))
    ));
  }
  buildStatusFilter(){
    return  Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            buildStatusEntry("Status.ToDo"),
            buildStatusEntry("Status.InProgress"),
            buildStatusEntry("Status.Done"),
          ],
        ),
      ),
    );
  }


  buildDateEntry(String date){
    return Obx(()=>GestureDetector(
        onTap: (){
          if(widget.selectedDate.value == date){
            widget.selectedDate.value = "";
          }else{
            widget.selectedDate.value = date;
          }
          widget.filter(widget.selectedDate.value,widget.selectedPriority.value,widget.selectedStatus.value,widget.selectedCaretaker.value);
        },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [SpecialistStyles.boxShadow],
              color: date == widget.selectedDate.value ? SpecialistStyles.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: date == widget.selectedDate.value ? SpecialistStyles.primaryColor : Colors.white,
              ),
            ),
            margin:  const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(date,style: TextStyle(color:  date== widget.selectedDate.value ? Colors.white: Colors.black),)
                ],
              ),
            ))
    ));
  }
  buildDateFilter(){

    return  Container(
      child: Row(
        children: [
          buildDateEntry("From latest"),
          buildDateEntry("From oldest"),
        ],
      ),
    );
  }

  Widget buildCaretaker(UserData user){
    return GestureDetector(
      onTap: (){
          if(widget.selectedCaretaker.value == user.id){
            widget.selectedCaretaker.value = "";
          }else{
            widget.selectedCaretaker.value = user.id!;
          }
          widget.filter(widget.selectedDate.value,widget.selectedPriority.value,widget.selectedStatus.value,widget.selectedCaretaker.value);

      },
      child:
        Container(
            decoration: BoxDecoration(
              boxShadow: [SpecialistStyles.boxShadow],
              color: user.id == widget.selectedCaretaker.value ? SpecialistStyles.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: user.id == widget.selectedCaretaker.value ? SpecialistStyles.primaryColor : Colors.white,
              ),
            ),
            margin:  const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
          children: [
              UserAvatarWidget(role: "specialist", path: user.photourl!, size: 32),
            SizedBox(width: 5,),
              Text(user.name!,style: TextStyle(color:  user.id == widget.selectedCaretaker.value ? Colors.white: Colors.black),),
            SizedBox(width: 10,)
          ],
        ),
            )),

    );
  }
  buildcaretakerFilter() {
    return Container(
      child: FutureBuilder(
        future: initSpecialists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Column(
              children: [

                Obx(()=>SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.specialists
                        .map((user) => buildCaretaker(user))
                        .toList(),

                  ),
                ),)
              ],
            );
          }
        },
      ),
    );
  }
  buildResetButton(){
    return Container(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: (){
          widget.selectedDate.value = "";
          widget.selectedPriority.value = "";
          widget.selectedStatus.value = "";
          widget.selectedCaretaker.value = "";
          widget.filter(widget.selectedDate.value,widget.selectedPriority.value,widget.selectedStatus.value,widget.selectedCaretaker.value);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(


            width: 70,

            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              boxShadow: [SpecialistStyles.boxShadow],
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0),

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Reset",style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>widget.isOpened.value? SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFilterLabel("Date"),
              buildDateFilter(),
              buildFilterLabel("Priority"),
              buildPriorityFilter(),
              buildFilterLabel("Status"),
              buildStatusFilter(),
              buildFilterLabel("Caretaker"),
              buildcaretakerFilter(),
              buildResetButton()
            ],
          ),
        ),
      ),
    ):SizedBox());
  }
}
