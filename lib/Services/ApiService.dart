import 'package:dio/dio.dart';
import 'package:to_do_list/Models/Task.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://todo-backend-oob0.onrender.com",
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        "/api/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return {"error": e.response?.data["message"] ?? "Error happened"};
      } else {
        return {"error": "Check Your internet Connection"};
      }
    }
  }
  Future<Map<String, dynamic>> register(String email, String password , String name) async {
    try {
      final response = await _dio.post(
        "/api/auth/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return {"error": e.response?.data["message"] ?? "Error happened"};
      } else {
        return {"error": "Check Your internet Connection"};
      }
    }
  }
  Future<List<dynamic>> getAllTodos(String token) async {
    try {
      final response = await _dio.get(
        "/api/todos",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Error loading todos");
    }

  }

  Future<Map<String, dynamic>> updateTodo(String token, String todoId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        "/api/todos/$todoId",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return {"error": e.response?.data["message"] ?? "Error happened"};
      } else {
        return {"error": "Check Your internet Connection"};
      }
    }
  }
  Future<Map<String, dynamic>> deleteTodo(String token, String todoId) async {
    try {
      final response = await _dio.delete(
        "/api/todos/$todoId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data; // عادة response فارغ أو رسالة نجاح
    } on DioException catch (e) {
      if (e.response != null) {
        return {"error": e.response?.data["message"] ?? "Error happened"};
      } else {
        return {"error": "Check Your internet Connection"};
      }
    }
  }
  Future<Map<String, dynamic>> createTodo(String token, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        "/api/todos",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return {"error": e.response?.data["message"] ?? "Error happened"};
      } else {
        return {"error": "Check Your internet Connection"};
      }
    }
  }

}