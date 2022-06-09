// To parse this JSON data, do
//
//     final taskItem = taskItemFromJson(jsonString);

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

TaskItem taskItemFromJson(String str) => TaskItem.fromJson(json.decode(str));

String taskItemToJson(TaskItem data) => json.encode(data.toJson());

class TaskItem {
  TaskItem({
    required this.id,
    required this.name,
    required this.isRunning,
    required this.time,
    required this.timer,
    required this.duration,
    required this.color,
  });

  int id;
  String name;
  bool isRunning;
  String time;
  Timer? timer;
  Color color;
  Duration duration = const Duration();

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
        id: json["id"],
        name: json["name"],
        isRunning: json["isRunning"],
        time: json["time"],
        timer: json["timer"],
        duration: json["duration"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isRunning": isRunning,
        "time": time,
        "timer": timer,
        "duration": duration,
        "color": color,
      };
}
