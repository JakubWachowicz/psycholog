import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jw_projekt/Widgets/user_avatar.dart';
import 'package:jw_projekt/styles/specialist_styles.dart';
import '../../../Utils/date.dart';
import '../../../Widgets/nav_bar.dart';
import '../../../Widgets/specialist/draggable_list.dart';
import '../../../entities/report.dart';
import '../../../entities/user.dart';
import '../specialist_report_menagment/widgets/priority_dropdown.dart';
import 'controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialistReportKanbanPage
    extends GetView<SpecialistReportKanbanConroller> {
  const SpecialistReportKanbanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return AppBar(
        title: Text("Trello"),
        backgroundColor: SpecialistStyles.primaryColor,
        actions: [],
      );
    }

    buildCaretakerWidget(UserData user)  {


      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8,top: 8),
            child: UserAvatarWidget(
                role: "specialis", path: user.photourl!, size: 46),
          ),
          Text(user.name!)
        ],
      );
    }

    Widget ReportItem(Report report) {
      return InkWell(
        onTap: () => {controller.goReport(report)},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),

            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                    top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            report.reportType ?? "error",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.sp),
                          ),
                          Text(report.title ?? "error",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp)),
                          Container(
                            width: 360.w / 1.7,
                            child: Text(report.content ?? "error",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16.sp)),
                          ),
                          Text(
                            duTimeLineFormat(
                              report.timestamp!.toDate(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(report.priority == "notAssigned"
                                  ? "new"
                                  : report.priority ?? ""),
                            ],
                          ),
                          Row(
                            children: [
                              report.caretaker == "notAssigned"
                                  ? SizedBox()
                                  : FutureBuilder(
                                      future: controller.getProfile(report.caretaker!),
                                      builder: (BuildContext context,  snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.deepPurpleAccent,
                                            ),
                                          );
                                        }
                                        else{
                                          return buildCaretakerWidget(snapshot.data!);
                                        }
                                      },
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Text("Priority: " +  report.priority.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 10.w,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 360.w,

                  color: ValueColorMapper.priorityToColorString(report.priority!),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(report.priority!),
                  ),)

              ],
            ),
          ),
        ),
      );
    }

    Widget buildList2(DraggableList list) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          color: CupertinoColors.extraLightBackgroundGray,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(7.0)),
                    color: SpecialistStyles.primaryColor,
                  ),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Text(
                    'Header ${list.header}',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.items.length,
                  itemBuilder: (context, index) {
                    return ReportItem(list.items[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    buildTrello() {
      final PageController pageController = PageController(
        viewportFraction: 0.8, // Adjust the fraction as needed
      );

      return Obx(() => Container(
            color: CupertinoColors.extraLightBackgroundGray,
            child: PageView(
              controller: pageController,
              onPageChanged: (index) => controller.state.index.value = index,
              children: [
                buildList2(controller.allLists[0]),
                buildList2(controller.allLists[1]),
                buildList2(controller.allLists[2]),
                buildList2(controller.allLists[3]),
              ],
            ),
          ));
    }

    return Scaffold(
        drawer: NavBar(), appBar: _buildAppBar(), body: buildTrello());
  }
}
