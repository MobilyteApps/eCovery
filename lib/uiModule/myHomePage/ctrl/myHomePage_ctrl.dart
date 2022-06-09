import 'package:ecovery/models/task_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyHomePageController extends GetxController {
  RxList<Color> colorList = <Color>[].obs;

  var taskList = <TaskItem>[].obs;

  var seconds = 1.obs;
  var duration = const Duration().obs;

  totalTask(index) {
    taskList[index].isRunning = !taskList[index].isRunning;
    update();
  }

  // Timer? timer;
  // var hours = ''.obs;
  // var second = ''.obs;
  // var minutes = ''.obs;
  //
  // void StartTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     addTime();
  //   });
  // }
  //
  // void addTime() {
  //   const addSecond = 1;
  //   final seconds = duration.value.inSeconds + addSecond;
  //   duration = Duration(seconds: seconds).obs;
  //
  //   // ctrl.seconds.value = ctrl.duration.value.inSeconds + addSecond;
  //   // ctrl.duration.value = Duration(seconds: ctrl.seconds.value);
  // }
}
