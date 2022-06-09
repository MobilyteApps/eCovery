// To parse this JSON data, do
//
//     final taskItem = taskItemFromJson(jsonString);

import 'dart:convert';

TaskItem taskItemFromJson(String str) => TaskItem.fromJson(json.decode(str));

String taskItemToJson(TaskItem data) => json.encode(data.toJson());

class TaskItem {
  TaskItem({
    required this.id,
    required this.name,
    required this.isRunning,
    required this.time,
  });

  int id;
  String name;
  bool isRunning;
  String time;

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
        id: json["id"],
        name: json["name"],
        isRunning: json["isRunning"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isRunning": isRunning,
        "time": time,
      };
}
