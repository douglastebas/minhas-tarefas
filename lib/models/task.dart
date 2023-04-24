import 'dart:convert';

class Task {
  int? id;
  String? title;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        isDone: json['isDone'],
      );

  static Map<String, dynamic> toMap(Task task) => {
        "id": task.id,
        "title": task.title,
        "isDone": task.isDone,
      };

  static String encode(List<Task> taskList) => json.encode(
        taskList.map<Map<String, dynamic>>((task) => Task.toMap(task)).toList(),
      );

  static List<Task> decode(String taskList) =>
      (json.decode(taskList) as List<dynamic>)
          .map<Task>((item) => Task.fromJson(item))
          .toList();
}
