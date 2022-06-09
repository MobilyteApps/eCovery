import 'dart:async';

import 'package:ecovery/appSize/appSize.dart';
import 'package:ecovery/clickHandle/clickHandle.dart';
import 'package:ecovery/models/task_items.dart';
import 'package:ecovery/uiModule/myHomePage/ctrl/myHomePage_ctrl.dart';
import 'package:ecovery/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyHomePageController ctrl = Get.put(MyHomePageController());

  // Duration duration = const Duration();
  // Timer? timer;

  // ignore: non_constant_identifier_names
  void StartTimer(int index) {
    ctrl.taskList[index].timer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      addTime(index);
    });
  }

  void addTime(int index) {
    const addSecond = 1;
    setState(() {
      final seconds = ctrl.taskList[index].duration.inSeconds + addSecond;
      ctrl.taskList[index].duration = Duration(seconds: seconds);
    });

    // ctrl.seconds.value = ctrl.duration.value.inSeconds + addSecond;
    // ctrl.duration.value = Duration(seconds: ctrl.seconds.value);
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Add task name',
        // Message
        toastLength: Toast.LENGTH_SHORT,
        // toast length
        gravity: ToastGravity.TOP,
        // position// duaration
        backgroundColor: Colors.red,
        // background color
        textColor: Colors.white // text color
        );
  }

  Future<void> createAlertDialog(BuildContext context) async {
    TextEditingController customController = TextEditingController();
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Name of task"),
            content: TextField(
              onChanged: (value) {
                value = customController.text;
              },
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  child: const Text("OK"),
                  onPressed: () {
                    if (customController.text.toString().isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Add task name',
                          // Message
                          toastLength: Toast.LENGTH_LONG,
                          // toast length
                          gravity: ToastGravity.TOP,
                          // position// duration
                          backgroundColor: Colors.red,
                          fontSize: 12,
                          // background color
                          textColor: Colors.black // text color
                          );
                    } else {
                      Navigator.of(context)
                          .pop(customController.text.toString());
                      ctrl.taskList.add(TaskItem(
                          id: 1,
                          name: customController.text,
                          isRunning: false,
                          time: DateTime.now().toString(),
                          timer: null,
                          duration: const Duration(),
                          color: ctrl.colorList.value.randomItem()));
                    }
                  })
            ],
          );
        });
  }

  @override
  void initState() {
    ctrl.colorList.value.add(Colors.red);
    ctrl.colorList.value.add(Colors.green);
    ctrl.colorList.value.add(Colors.orange);
    ctrl.colorList.value.add(Colors.yellow);
    ctrl.colorList.value.add(Colors.lime);
    ctrl.colorList.value.add(Colors.purple);
    ctrl.colorList.value.add(Colors.blue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    return GetX<MyHomePageController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Task List'),
          ),
          body: SafeArea(
              child: (ctrl.taskList.isEmpty)
                  ? Center(
                      child: Text(
                      "No task found.\nPlease add a new task",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: AppDimen.unitHeight * 10,
                          color: Colors.grey),
                    ))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: ctrl.taskList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final hours =
                            twoDigits(ctrl.taskList[index].duration.inHours);
                        final minutes = twoDigits(ctrl
                            .taskList[index].duration.inMinutes
                            .remainder(60));
                        final seconds = twoDigits(ctrl
                            .taskList[index].duration.inSeconds
                            .remainder(60));
                        // ignore: unrelated_type_equality_checks

                        return Padding(
                          padding: EdgeInsets.all(AppDimen.unitHeight * 5),
                          child: Container(
                            height: AppDimen.screenHeight * 0.1,
                            width: AppDimen.unitWidth,
                            decoration: BoxDecoration(
                                color: ctrl.taskList[index].color,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppDimen.unitWidth * 20,
                                  right: AppDimen.unitWidth * 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // ignore: invalid_use_of_protected_member
                                        ctrl.taskList[index].name,
                                        style: TextStyle(
                                            fontSize: AppDimen.unitHeight * 15),
                                      ),
                                      // ignore: unrelated_type_equality_checks

                                      // ignore: unnecessary_null_comparison
                                      ctrl.taskList[index].timer == null
                                          ? Text(
                                              "Start time",
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimen.unitHeight * 10),
                                            )
                                          : Text(
                                              "$hours : $minutes : $seconds",
                                              style: TextStyle(
                                                  fontSize:
                                                      AppDimen.unitHeight * 10),
                                            )
                                    ],
                                  ),
                                  _buildIcon(index),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("Clicked");
              createAlertDialog(context);
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildIcon(index) {
    // final running = ctrl.totalTask(index);
    final isCompleted = ctrl.taskList[index].duration.inSeconds == 0;
    return Row(children: [
      ctrl.taskList[index].isRunning
          ? InkWell(
              onTap: () {
                ctrl.totalTask(index);
                ctrl.taskList[index].timer!.cancel();
                ctrl.update();
                setState(() {});
              },
              child: Icon(
                Icons.pause,
                size: AppDimen.unitHeight * 20,
              ))
          : InkWellMe(
              onSafeTap: () {
                StartTimer(index);
                ctrl.totalTask(index);
                ctrl.update();
              },
              child: Icon(Icons.play_arrow, size: AppDimen.unitHeight * 20)),
      (ctrl.taskList[index].timer != null)
          ? InkWell(
              onTap: () {
                ctrl.taskList[index].isRunning = false;
                ctrl.taskList[index].timer!.cancel();
                ctrl.taskList[index].timer = null;
                ctrl.taskList[index].duration = Duration.zero;
                ctrl.update();
                setState(() {});
              },
              child: Icon(Icons.restore, size: AppDimen.unitHeight * 20))
          : const SizedBox(),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: InkWell(
            onTap: () {
              if (ctrl.taskList[index].timer == null) {
                ctrl.taskList.removeAt(index);
              } else {
                ctrl.taskList[index].timer!.cancel();
                ctrl.taskList.removeAt(index);
              }

              //  ctrl.taskList[index].duration = Duration.zero;
              ctrl.update();
              setState(() {});
            },
            child: Icon(Icons.delete,
                color: Colors.red, size: AppDimen.unitHeight * 20)),
      )
    ]);
  }
}

// ignore: must_be_immutable
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final MyHomePageController ctrl = Get.put(MyHomePageController());
//
//   Timer? timer;
//   Duration duration = const Duration();
//
//   // ignore: non_constant_identifier_names
//
//   Future<String> createAlertDialog(BuildContext context) async {
//     TextEditingController customController = TextEditingController();
//     return await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Name of task"),
//             content: TextField(
//               onChanged: (value) {
//                 value = customController.text;
//               },
//               controller: customController,
//             ),
//             actions: <Widget>[
//               MaterialButton(
//                   elevation: 5.0,
//                   child: const Text("OK"),
//                   onPressed: () {
//                     Navigator.of(context).pop(customController.text.toString());
//                     ctrl.task.add(customController.text);
//                   })
//             ],
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     ctrl.hours.value = twoDigits(ctrl.duration.value.inHours);
//     ctrl.minutes.value = twoDigits(ctrl.duration.value.inMinutes.remainder(60));
//     ctrl.second.value = twoDigits(ctrl.duration.value.inSeconds.remainder(60));
//
//     return GetX<MyHomePageController>(
//       builder: (ctrl) {
//         return Scaffold(
//           body: SafeArea(
//               child: ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: ctrl.task.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: EdgeInsets.all(AppDimen.unitHeight * 5),
//                       child: Container(
//                         height: AppDimen.screenHeight * 0.1,
//                         width: AppDimen.unitWidth,
//                         decoration: const BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.all(Radius.circular(8))),
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: AppDimen.unitWidth * 20,
//                               right: AppDimen.unitWidth * 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     // ignore: invalid_use_of_protected_member
//                                     ctrl.task[index],
//                                     style: TextStyle(
//                                         fontSize: AppDimen.unitHeight * 15),
//                                   ),
//                                   Text(
//                                     "${ctrl.hours.value} : ${ctrl.minutes.value} : ${ctrl.second.value}",
//                                     style: TextStyle(
//                                         fontSize: AppDimen.unitHeight * 10),
//                                   )
//                                 ],
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   ctrl.StartTimer();
//                                 },
//                                 child: Icon(
//                                   Icons.play_arrow,
//                                   size: AppDimen.unitHeight * 30,
//                                   color: Colors.green,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   })),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               print("Clicked");
//               createAlertDialog(context);
//             },
//             backgroundColor: Colors.green,
//             child: const Icon(Icons.add),
//           ),
//         );
//       },
//     );
//   }
// }
// InkWell(
// onTap: () {
// StartTimer(index);
// ctrl.totalTask(index);
// ctrl.update();
// },
// child: Icon(Icons.play_arrow, size: AppDimen.unitHeight * 20)),
