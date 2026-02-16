import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/Screens/Welcome.dart';
import 'Models/TaskProvider.dart';

void main() {
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
      home: WelcomePage(),
    );
  }
}
