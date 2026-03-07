import 'package:to_do_list/Services/ApiService.dart';
import 'package:to_do_list/Models/Task.dart';

class TaskRepository {
  final ApiService apiService;

  TaskRepository(this.apiService);

  Future<List<Task>> getTodos(String token) async {
    final data = await apiService.getAllTodos(token);
    return data.map((e) => Task.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> createTodo(
      String token, Map<String, dynamic> data) async {
    return await apiService.createTodo(token, data);
  }

  Future<Map<String, dynamic>> updateTodo(
      String token, String id, Map<String, dynamic> data) async {
    return await apiService.updateTodo(token, id, data);
  }

  Future<Map<String, dynamic>> deleteTodo(String token, String id) async {
    return await apiService.deleteTodo(token, id);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await apiService.login(email, password);
  }

  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    return await apiService.register(email, password, name);
  }
}