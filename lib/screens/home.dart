import 'package:flutter/material.dart';
import 'package:minhas_tarefas/widgets/add_new_task.dart';
import 'package:minhas_tarefas/widgets/search_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.email});

  final String email;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> taskList = [];
  List<Task> _filteredTaskList = [];
  bool _showDoneTasks = true;

  final _searchTaskController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedTaskList = prefs.getString('savedTaskList');
    final List<Task> tasks =
        savedTaskList != null ? Task.decode(savedTaskList) : [];
    setState(() {
      taskList = tasks;
    });
    _initFilter('');
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 75),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  SearchTask(
                      list: taskList,
                      searchController: _searchTaskController,
                      updateList: (result) => setState(() {
                            _filteredTaskList = result;
                          })),
                  Expanded(
                      child: NotificationListener(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          margin: const EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: const Text(
                            'Minhas tarefas',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (Task task in _filteredTaskList)
                          if (!task.isDone)
                            TaskItem(
                              task: task,
                              onTaskChanged: _handleTaskChange,
                              onDeleteTask: _deleteTaskItem,
                            ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 15),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryBGColor),
                            ),
                            onPressed: _handleClick,
                            child: Text(
                              _showDoneTasks
                                  ? 'Mostrar tarefas feitas'
                                  : 'Esconder tarefas feitas',
                              style: const TextStyle(
                                  fontSize: 14, color: primaryBlack),
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: _showDoneTasks,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: [
                              for (Task task in _filteredTaskList)
                                if (task.isDone)
                                  TaskItem(
                                    task: task,
                                    onTaskChanged: _handleTaskChange,
                                    onDeleteTask: _deleteTaskItem,
                                  ),
                            ],
                          ),
                        )
                      ],
                    ),
                    onNotification: (t) {
                      if (t is ScrollNotification) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                      return false;
                    },
                  ))
                ],
              ),
            ),
            AddNewTask(addNewTaskToList: _addNewTaskToList),
          ],
        ),
      ),
    );
  }

  void _handleTaskChange(Task task) {
    setState(() {
      task.isDone = !task.isDone;
      _saveToLocalStorage();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa concluída  (⁠☞ﾟ⁠∀ﾟ⁠)⁠☞')));
    });
  }

  void _handleClick() {
    setState(() {
      _showDoneTasks = !_showDoneTasks;
      _scrollAnimation;
    });
  }

  void _scrollAnimation() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 2000), curve: Curves.easeInOut);
  }

  void _saveToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedList = Task.encode(taskList);
    prefs.setString('savedTaskList', encodedList);
  }

  void _deleteTaskItem(int? id) {
    setState(() {
      taskList.removeWhere((item) => item.id == id);
      _saveToLocalStorage();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Tarefa excluída  =)')));
    });
  }

  void _addNewTaskToList(Task newTask) {
    setState(() {
      taskList.add(newTask);
      _saveToLocalStorage();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sua tarefa foi criada   ᕙ⁠(⁠ ⁠ ⁠•⁠ ⁠‿⁠ ⁠•⁠ ⁠ ⁠)⁠ᕗ')));
    });
    FocusManager.instance.primaryFocus?.unfocus();
    _scrollAnimation();
  }

  void _initFilter(String input) {
    List<Task> results = [];
    if (input.isEmpty) {
      results = taskList;
    } else {
      results = taskList
          .where(
              (task) => task.title!.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredTaskList = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryBGColor,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: primaryBlack,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Voltar',
            style: TextStyle(
              color: primaryBlack,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/logo_black.png'),
            ),
          ),
        ],
      ),
    );
  }
}
