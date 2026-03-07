import 'package:flutter/material.dart';
import 'package:to_do_list/Models/Task.dart';
import 'package:to_do_list/Services/ApiService.dart';
import '../Repositories/TaskRepository.dart';

class TaskProvider with ChangeNotifier {
  final TaskRepository repository = TaskRepository(ApiService());

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  String _searchQuery = '';
  bool isLoading = false;

  Future<void> fetchTodos(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      _tasks = await repository.getTodos(token);
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

    final result = await repository.updateTodo(
      token,
      task.id!,
      {"completed": task.completed},
    );

    if (result.containsKey("error")) {
      task.completed = oldValue;
      notifyListeners();
    }
  }

  List<Task> get activeTasks => tasks
      .where(
        (t) =>
    t.completed != true &&
        (t.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
            false),
  )
      .toList();

  List<Task> get doneTasks => tasks
      .where(
        (t) =>
    t.completed == true &&
        (t.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
            false),
  )
      .toList();

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> deleteTask(Task task, String token) async {
    _tasks.remove(task);
    notifyListeners();

    final result = await repository.deleteTodo(token, task.id!);

    if (result.containsKey("error")) {
      _tasks.add(task);
      notifyListeners();
    }
  }

  Future<void> addTask2(Task task, String token) async {
    _tasks.add(task);
    notifyListeners();

    final result = await repository.createTodo(token, task.toJson());

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

    final result = await repository.updateTodo(token, task.id!, {
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