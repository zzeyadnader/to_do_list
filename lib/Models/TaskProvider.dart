import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [
    Task(title: "Study", dueDate: DateTime(2026, 3, 15), isDone: false, Priority: "High" , description:  "Heloooo") ,
    Task(title: "Play minecraft", dueDate: DateTime(2026, 3, 15), isDone: false, Priority: "Low" , description:  "Heloooo"),
    Task(title: "Sleep", dueDate: DateTime(2026, 3, 15), isDone: false, Priority: "Mid" , description:  "Heloooo"),
  ];

  String _searchQuery = '';

  // not done tasks
  List<Task> get activeTasks => tasks
      .where((t) => !t.isDone && t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  // done tasks
  List<Task> get doneTasks =>tasks
      .where((t) => t.isDone && t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

 //switch value
  void toggleTask(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }
 //search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // rebuild UI with filtered tasks
  }

  // add new task
  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }
  //sort (not worked yet)
  void sortByPriority() {
    final priorityOrder = {"High": 3, "Medium": 2, "Low": 1};

    tasks.sort((a, b) =>
        (priorityOrder[b.Priority] ?? 0).compareTo(priorityOrder[a.Priority] ?? 0));

    notifyListeners();
  }
}
