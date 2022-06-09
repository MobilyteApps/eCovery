import 'package:get/get.dart';

class MyHomePageController extends GetxController {
  // RxList<TaskItem> task = <TaskItem>[].obs;
  var task = <String>[].obs;

  var seconds = 1.obs;
  var duration = const Duration().obs;

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
