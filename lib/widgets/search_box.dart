import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/task.dart';

class SearchTask extends StatelessWidget {
  final List<Task> list;
  final TextEditingController searchController;
  final Function(List<Task>) updateList;

  SearchTask({
    Key? key,
    required this.list,
    required this.searchController,
    required this.updateList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: TextField(
            controller: searchController,
            onChanged: (input) => _runFilter(input),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: primaryBlack,
                size: 20,
              ),
              prefixIconConstraints: BoxConstraints(
                maxHeight: 25,
                minWidth: 25,
              ),
              border: InputBorder.none,
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: primaryGrey),
            ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              color: Colors.black,
              iconSize: 18,
              icon: const Icon(Icons.close),
              onPressed: () {
                _clearSearchInput();
              },
            ),
          ),
        ));
  }

  void _runFilter(String input) {
    List<Task> results = [];
    if (input.isEmpty) {
      results = list;
    } else {
      results = list
          .where(
              (task) => task.title!.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    updateList(results);
  }

  void _clearSearchInput() {
    FocusManager.instance.primaryFocus?.unfocus();
    _runFilter('');
  }
}
