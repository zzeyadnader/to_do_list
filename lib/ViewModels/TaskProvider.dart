import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/Models/Task.dart';

class TaskProvider with ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');
  String _searchQuery = '';

  List<Task> get tasks => _taskBox.values.toList();

  // not done
  List<Task> get activeTasks =>
      tasks
          .where(
            (t) =>
        !t.isDone &&
            t.title.toLowerCase().contains(_searchQuery.toLowerCase()),
      )
          .toList();

  // done
  List<Task> get doneTasks =>
      tasks
          .where(
            (t) =>
        t.isDone &&
            t.title.toLowerCase().contains(_searchQuery.toLowerCase()),
      )
          .toList();

  //switch value
  void toggleTask(Task task) async {
    task.isDone = !task.isDone;
    await task.save();
    notifyListeners();
  }

  //search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // rebuild UI with filtered tasks
  }

  // add new task
  void addTask(Task task) async {
    await _taskBox.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) async {
    await task.delete();
    notifyListeners();
  }

  //sort (not worked yet)
  void sortByPriority() {
    final priorityOrder = {"High": 3, "Mid": 2, "Low": 1};

    final sorted = tasks
      ..sort((a, b) =>
          (priorityOrder[b.priority] ?? 0)
              .compareTo(priorityOrder[a.priority] ?? 0));

    notifyListeners();
  }
}
