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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyHomePageController ctrl = Get.put(MyHomePageController());

  /// Start Timer
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
  }

  ///Toast Message
  void showToast() {
    Fluttertoast.showToast(
        msg: 'Add task name',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black,
        textColor: Colors.white // text color
        );
  }

  /// Alter Dialog Box
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
    ctrl.colorList.value.add(Colors.pinkAccent);
    ctrl.colorList.value.add(Colors.teal);
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
            title: const Text('Task List'),
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
                                        ctrl.taskList[index].name,
                                        style: TextStyle(
                                            fontSize: AppDimen.unitHeight * 15),
                                      ),
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

          ///Floating Action Button
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

  ///Play,Pause,Delete Icons
  Widget _buildIcon(index) {
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
              ctrl.update();
              setState(() {});
            },
            child: Icon(Icons.delete,
                color: Colors.red, size: AppDimen.unitHeight * 20)),
      )
    ]);
  }
}
