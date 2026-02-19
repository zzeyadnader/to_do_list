import 'package:flutter/material.dart';
import 'package:to_do_list/Models/Task.dart';
import 'package:to_do_list/Services/ApiService.dart';
import 'package:to_do_list/ViewModels/authProvider.dart';

class TaskProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  String _searchQuery = '';

  bool isLoading = false;

  Future<void> fetchTodos(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getAllTodos(token);
      _tasks = response.map<Task>((e) => Task.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching todos: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleTask2(Task task, String token) async {
    final oldValue = task.completed;

    task.completed = !(task.completed ?? false);
    notifyListeners();

    final result = await _apiService.updateTodo(
      token,
      task.id!,
      {"completed": task.completed},
    );

    if (result.containsKey("error")) {
      task.completed = oldValue;
      notifyListeners();
    }
  }
  List<Task> get activeTasks =>
      tasks
          .where((t) =>
      t.completed != true &&
          (t.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      )
          .toList();
  List<Task> get doneTasks =>
      tasks
          .where((t) =>
      t.completed == true &&
          (t.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      )
          .toList();

  //search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // rebuild UI with filtered tasks
  }

  Future<void> deleteTask(Task task, String token) async {
    _tasks.remove(task);
    notifyListeners();

    final result = await _apiService.deleteTodo(token, task.id!);

    if (result.containsKey("error")) {
      _tasks.add(task);
      notifyListeners();
    }
  }

  Future<void> addTask2(Task task, String token) async {
    _tasks.add(task);
    notifyListeners();

    final result = await _apiService.createTodo(token, task.toJson());

    if (result.containsKey("error")) {
      _tasks.remove(task);
      notifyListeners();
    } else {
      task.id = result["_id"];
      notifyListeners();
    }
  }

  Future<void> updateTask2(Task task, String token) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    final oldTask = _tasks[index];

    _tasks[index] = task;
    notifyListeners();

    final result = await _apiService.updateTodo(token, task.id!, {
      "title": task.title,
      "description": task.description,
      "priority": task.priority,
      "deadline": task.deadline?.toIso8601String(),
      "completed": task.completed,
    });

    if (result.containsKey("error")) {
      _tasks[index] = oldTask;
      notifyListeners();
    }
  }
}
