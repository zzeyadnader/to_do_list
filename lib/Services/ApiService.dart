import 'package:dio/dio.dart';

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

}