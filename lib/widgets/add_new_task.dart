import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/task.dart';

class AddNewTask extends StatelessWidget {
  final Function(Task) addNewTaskToList;
  final _newTaskController = TextEditingController();

  AddNewTask({
    Key? key,
    required this.addNewTaskToList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _newTaskController,
                decoration: const InputDecoration(
                  hintText: 'Criar nova tarefa',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              onPressed: () {
                _sendNewTask(_newTaskController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlack,
                minimumSize: const Size(60, 60),
                elevation: 10,
              ),
              child: const Text(
                '+',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendNewTask(String newTask) {
    final id = DateTime.now().millisecondsSinceEpoch;
    _newTaskController.clear();
    addNewTaskToList(Task(id: id, title: newTask));
    // setState(() {
    // taskList.add(Task(id: id, title: newTask));
    //   _saveToLocalStorage();
    // });
    // FocusManager.instance.primaryFocus?.unfocus();
    // _scrollAnimation();
  }
}
