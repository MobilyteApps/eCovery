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
}
