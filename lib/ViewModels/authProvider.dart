import 'package:flutter/material.dart';
import 'package:to_do_list/Services/ApiService.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;
  String? token;

  Future<String?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await _apiService.login(email, password);
    isLoading = false;
    notifyListeners();

    if (result.containsKey("token")) {
      token = result["token"];
      return null;
    } else {
      return result["error"];
    }
  }
  Future<String?> register(String email, String password , String name) async {
    isLoading = true;
    notifyListeners();

    final result = await _apiService.register(email, password , name);
    isLoading = false;
    notifyListeners();

    if (result.containsKey("token")) {
      token = result["token"];
      return null;
    } else {
      return result["error"];
    }
  }

}