import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jw_projekt/model/user.dart';
import 'package:jw_projekt/pages/specialist/specialist_report_menagment/widgets/choose_specialist.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';

import '../../../../Widgets/user_avatar.dart';
import '../../../../entities/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SetCaretakerWidget extends StatefulWidget {
  SetCaretakerWidget(
      {super.key, required this.reportRef, required this.caretakerId});

  late UserData user;
  String reportRef;
  String caretakerId;
  final db = FirebaseFirestore.instance;
  bool isAssign = false;

  Future<void> updateCaretaker(String reportId, String caretaker) async {
    try {
      final reportRef =
          FirebaseFirestore.instance.collection('reports').doc(reportId);

      await reportRef.update({'caretaker': caretaker});
      caretakerId = caretaker;

      print('Caretaker updated successfully');
    } catch (e) {
      print('Error updating caretaker: $e');
    }
  }

  Future<UserData> fetchtUser(String id) async {
    var userSnapshot = await db
        .collection("users")
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .where("id", isEqualTo: id)
        .get();

    return userSnapshot.docs[0].data();
  }

  @override
  State<SetCaretakerWidget> createState() => _SetCaretakerWidgetState();
}

class _SetCaretakerWidgetState extends State<SetCaretakerWidget> {
  late OverlayEntry overlayEntry;
  bool isOpened = false;

  _buildCaretakerAssigned() {
   // double width = 300.w;
    //double height = 250.w;
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.extraLightBackgroundGray,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Caretaker",
                    style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Arial',
                        fontSize: 18),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            UserAvatarWidget(
                                role: "specialis",
                                path: widget.user.photourl!,
                                size: 64),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                widget.user.name!,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontFamily: 'Arial',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22,
                                    overflow: TextOverflow.clip),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.updateCaretaker(widget.reportRef, "notAssigned");
                                setState(() {
                                  widget.isAssign = false;
                                  widget.caretakerId = "notAssigned";
                                  isOpened = false;
                                  overlayEntry.remove();
                                });
                              },
                              child: Container(


                                child: Icon(Icons.close,color: Colors.red,)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildCaretakerNotAssigned() {
    //double width = 300.w;
    //double height = 150.w;
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.extraLightBackgroundGray,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Caretaker",
                    style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Arial',
                        fontSize: 22),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    isOpened = false;
                    overlayEntry.remove();

                    UserData result =await  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Choode_Specialist(
                                reportId: widget.reportRef,
                              )),
                    );

                    if(result != null){

                      setState(() {
                        widget.user = result as UserData;
                        widget.caretakerId = widget.user.id!;
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),

                    child: const Text(
                      "Assign",
                      style: TextStyle(
                          fontFamily: 'Arial',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildAssignMenu() {
    double height;
    widget.isAssign ? height = 150.w : height = 150.w;
    double width = 300.w;

    return OverlayEntry(
      builder: (context) => TapRegion(
        onTapOutside: (tab) {
          isOpened = false;
          overlayEntry.remove();
        },
        child: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height * 0.5 - height / 2,
                left: MediaQuery.of(context).size.width * 0.5 - width / 2,
                width: width,
                height: height,
                child:
                  _buildCaretakerAssigned())
          ],
        ),
      ),
    );
  }

  buildCaretakerWidget() {
    return InkWell(
        onTap: () async {
          print("Hejp");
          if(!widget.isAssign){
            UserData result =await  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Choode_Specialist(
                    reportId: widget.reportRef,
                  )),
            );

            if(result != null){

              setState(() {
                widget.user = result as UserData;
                widget.caretakerId = widget.user.id!;

              });
            }
          }
          else{
            if (isOpened) {
              overlayEntry.remove();
            } else {
              overlayEntry = _buildAssignMenu();
              Overlay.of(context).insert(overlayEntry);
            }
            isOpened = !isOpened;
          }

        },
        child: Container(
          decoration: BoxDecoration(
              color: CupertinoColors.extraLightBackgroundGray,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: widget.isAssign
                  ? Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        UserAvatarWidget(
                            role: "specialis",
                            path: widget.user.photourl!,
                            size: 46),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.user.name!,overflow: TextOverflow.clip,),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("notAssigned"),
                    )),
        ));
  }

  onInit() async {
    if (widget.caretakerId != "notAssigned") {
      widget.isAssign = true;
      widget.user = await widget.fetchtUser(widget.caretakerId);
    } else {
      widget.isAssign = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onInit(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        } else {
          return buildCaretakerWidget();
        }
      },
    );
  }
}
