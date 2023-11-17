import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/controller/db_data_controller.dart';
class ValueColorMapper{
  static Color priorityToColor(Priority priority){
    switch(priority){
      case Priority.Critical:
        return Colors.red;
      case Priority.High:
        return Colors.orange;
      case Priority.Medium:
        return Colors.yellow;
      case Priority.Low:
        return Colors.grey;
      case Priority.notAssign:
        return Colors.black;
    }
  }

  static Color priorityToColorString(String priority){

    Priority priorityEnum;
    try{
       priorityEnum = Priority.values.firstWhere((e) => e.toString() == priority);
    }
    catch(e){
      priorityEnum = Priority.Low;
    }




    switch(priorityEnum){
      case Priority.Critical:
        return Colors.red;
      case Priority.High:
        return Colors.orange;
      case Priority.Medium:
        return Colors.yellow;
      case Priority.Low:
        return Colors.grey;
      case Priority.notAssign:
        return Colors.black;
    }

  }

}
enum Priority{
  Critical,
  High,
  Medium,
  Low,
  notAssign,
}


class PriorityDropdown extends StatefulWidget {


   PriorityDropdown({super.key,required this.reportId,required this.currentValue});
   var reportId;

   Future<void> updatePriority(priority) async {

     try {
       final reportRef =
       FirebaseFirestore.instance.collection('reports').doc(reportId);
       print("LOL");

       await reportRef.update({'priority': priority.toString()});

       print('Caretaker updated successfully');
     } catch (e) {
       print('Error updating caretaker: $e');
     }
   }


   String text = "Yep";
  String currentValue;
  @override
  State<PriorityDropdown> createState() => _PriorityDropdownState();
  bool isDropDownOpened = false;

}

class _PriorityDropdownState extends State<PriorityDropdown> {
  late GlobalKey actionKey;
  var xPosition;
  var yPosition;
  var height;
  var width;
  Color currenValueColor = Colors.black;
  late OverlayEntry selector;
  void findDropdownData(){
    RenderBox? renderBox = actionKey.currentContext?.findRenderObject() as RenderBox?;
    height = renderBox?.size.height;
    width = renderBox?.size.width;
    Offset? offset = renderBox?.localToGlobal(Offset.zero);
    xPosition = offset?.dx!;
    yPosition = offset?.dy!;
    print(height);
  }


  OverlayEntry _buildSelector(){
    return  OverlayEntry(builder: (context){
      return Positioned(
        left: xPosition,
        top: yPosition+height,

        width: width,
        child: TapRegion(
          onTapOutside: (tap){
            if(selector != null){
              widget.isDropDownOpened = false;
              selector.remove();
            }
          },
          child: Container(

            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [

                Container(
                  width: width,

                    color:Colors.white, child: Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 8.0,left: 11),
                      child: Text("Set priority",style: TextStyle(fontSize: 18,color: Colors.black,decoration: TextDecoration.none,fontFamily: "Arial",),textAlign: TextAlign.left,),
                    )),

                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,left: 8.0,right: 8.0),
                    child: Column(
                      children: [
                        _buildSelectorEntry(Priority.Critical,Icons.ac_unit,Colors.red),
                        _buildSelectorEntry(Priority.High,Icons.ac_unit,Colors.orange),
                        _buildSelectorEntry(Priority.Medium,Icons.ac_unit,Colors.yellow),
                        _buildSelectorEntry(Priority.Low,Icons.ac_unit,Colors.grey),
                      ],
                    ),
                  ),
                )

              ],
            ),

          ),
        ),
      );
    });
  }

  Widget _buildSelectorEntry(Priority priority,Icons,Color color){


      return Padding(
        padding: const EdgeInsets.only(top: 3,bottom: 3),
        child: GestureDetector(
          onTap: (){
            setState(() {
                widget.currentValue = priority.toString();

                widget.updatePriority(priority.toString());
                currenValueColor = ValueColorMapper.priorityToColor(priority);

                widget.isDropDownOpened = false;
                selector.remove();

            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:  color,
            ),

            child: Row(
              children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(priority.toString(),style: TextStyle(fontSize: 18,color: Colors.white,decoration: TextDecoration.none,fontFamily: "Arial"),),
              )],
            ),
          ),
        ),
      );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     actionKey = LabeledGlobalKey(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    try{
      var prio = Priority.values.firstWhere((e) => e.toString() == widget.currentValue);
      currenValueColor = ValueColorMapper.priorityToColor(prio);
    }catch(e){
      currenValueColor = Colors.black;
    }
    return InkWell(
      key: actionKey,
      onTap: (){

        if(widget.isDropDownOpened){
          selector.remove();
        }else{
          findDropdownData();
          selector = _buildSelector();
          Overlay.of(context).insert(selector);
        }
        widget.isDropDownOpened = !widget.isDropDownOpened;
      },
      child: Container(
        decoration:  BoxDecoration(
          color: currenValueColor,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        width: 200,
        height: 40,
        child:  Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(widget.currentValue, style:TextStyle(fontSize: 18,color: Colors.white,decoration: TextDecoration.none,fontFamily: "Arial")),
            ),
          ],
        ),
      ),
    );
  }
}
