import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jw_projekt/controller/specialist_db_controller.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

class EditDescription extends StatefulWidget {
  EditDescription({super.key,required this.descritpion,required this.specialistController});
  Rx<String> descritpion;
  SpecialistDbController specialistController;

  @override
  State<EditDescription> createState() => _EditDescriptionState();
}

class _EditDescriptionState extends State<EditDescription> {
  TextEditingController controller = TextEditingController();

  @override
  void initState(){
    controller.text = widget.descritpion.value;
  }
  Widget build(BuildContext context) {


    AppBar _buildAppBar() {
      return AppBar(
        title: const Text("Edit description"),
        backgroundColor: SpecialistStyles.primaryColor,
      );
    }


    Widget _buildContentEditor() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(

          maxLines: 10,
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),

              ),
              hintText: 'Enter rapport content'
          ),
        ),
      );
    }

    Widget _buildSubmitButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            widget.specialistController.setDescription(controller.text);
          },



          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
              color: Colors.green,
            ),
            width: double.infinity,
            height: 60.w,

            child: Center(child: Text("Save", style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),)),
          )

        )
      );
    }






    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your descrription",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22 ),),
            ),
            _buildContentEditor(),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }
}
