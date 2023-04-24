import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskChanged;
  final Function(int?) onDeleteTask;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onTaskChanged,
    required this.onDeleteTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        onTap: () {
          onTaskChanged(task);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: task.isDone
              ? const BorderSide(color: Colors.white)
              : const BorderSide(color: primaryGrey, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: task.isDone ? tdLightGrey : primaryBGColor,
        leading: Icon(
          task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: primaryBlack,
        ),
        title: Text(task.title!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryBlack,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            )),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: primaryBlack,
            iconSize: 18,
            icon: const Icon(Icons.close),
            onPressed: () {
              onDeleteTask(task.id);
            },
          ),
        ),
      ),
    );
  }
}
