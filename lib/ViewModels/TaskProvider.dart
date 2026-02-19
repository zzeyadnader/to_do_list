import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/Models/Task.dart';
import 'package:to_do_list/Services/ApiService.dart';
import 'package:to_do_list/ViewModels/authProvider.dart';

class TaskProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final Box<Task> _taskBox = Hive.box<Task>('tasks');
  String _searchQuery = '';

  List<Task> get tasks => _taskBox.values.toList();

  bool isLoading = false;

  Future<void> fetchTodos(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getAllTodos(token);

      await _taskBox.clear();

      for (var json in response) {
        _taskBox.add(Task.fromJson(json));
      }
    } catch (e) {
      debugPrint("Error fetching todos: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleTask2(Task task, String token) async {
    // عكس حالة الـ completed محليًا
    task.completed = !(task.completed ?? false);
    await task.save();
    notifyListeners();

    // تحديث السيرفر
    final result = await _apiService.updateTodo(token, task.id!, {
      "completed": task.completed,
    });

    if (result.containsKey("error")) {
      // لو فيه مشكلة، رجع القيمة للوراء
      task.completed = !(task.completed ?? false);
      await task.save();
      notifyListeners();
      debugPrint("Error updating task: ${result["error"]}");
    }
  }


  // not done
  List<Task> get activeTasks =>
      tasks
          .where((t) =>
      t.completed != true &&
          (t.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      )
          .toList();

  // done
  List<Task> get doneTasks =>
      tasks
          .where((t) =>
      t.completed == true &&
          (t.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      )
          .toList();

  //switch value
  void toggleTask(Task task) async {
    task.completed = !(task.completed ?? false);
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

// TaskProvider.dart
  Future<void> deleteTask(Task task, String token) async {
    // احفظ الـ id قبل الحذف محليًا
    final taskId = task.id;

    // احذف من Hive مؤقتًا
    await task.delete();
    notifyListeners();

    final result = await _apiService.deleteTodo(token, taskId!);

    if (result.containsKey("error")) {
      await _taskBox.add(task);
      notifyListeners();
      debugPrint("Error deleting task: ${result["error"]}");
    }
  }

  Future<void> addTask2(Task task, String token) async {
    await _taskBox.add(task);
    notifyListeners();

    final result = await _apiService.createTodo(token, task.toJson());

    if (result.containsKey("error")) {
      await task.delete();
      notifyListeners();
      debugPrint("Error adding task: ${result["error"]}");
    } else {
      task.id = result["_id"];
      await task.save();
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
}
