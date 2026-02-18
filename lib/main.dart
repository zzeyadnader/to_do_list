import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/View/Welcome.dart';
import 'package:to_do_list/View/HomePage.dart';
import 'package:to_do_list/ViewModels/TaskProvider.dart';
import 'package:to_do_list/Models/Task.dart';

class AppData {
  static bool firstTime = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TaskAdapter());
  }

  var taskBox = await Hive.openBox<Task>('tasks');
  var settingsBox = await Hive.openBox('settings');

  AppData.firstTime = settingsBox.get('firstTime', defaultValue: true);

  if (AppData.firstTime) {
    await settingsBox.put('firstTime', false);
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
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
      home: AppData.firstTime == true?const WelcomePage():const Homepage(),
    );
  }
}