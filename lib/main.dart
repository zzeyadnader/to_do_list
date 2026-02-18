import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/View/LoginPage.dart';
import 'package:to_do_list/View/RegisterPage.dart';
import 'package:to_do_list/View/Welcome.dart';
import 'package:to_do_list/View/HomePage.dart';
import 'package:to_do_list/ViewModels/TaskProvider.dart';
import 'package:to_do_list/Models/Task.dart';
import 'package:to_do_list/ViewModels/authProvider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TaskAdapter());
  }

  var taskBox = await Hive.openBox<Task>('tasks');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const Todo(),
    ),
  );
}
class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginpage(),
    );
  }
}