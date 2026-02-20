import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/View/AddTaks.dart';
import 'package:to_do_list/ViewModels/TaskProvider.dart';
import 'package:to_do_list/ViewModels/authProvider.dart';
import 'package:to_do_list/Widgets/CustomAppbar.dart';
import 'package:to_do_list/Widgets/CustomCard.dart';
import 'package:to_do_list/Widgets/CustomNavbar.dart';
import 'package:to_do_list/Widgets/CustomSearchField.dart';
import 'package:to_do_list/Widgets/CustomTask.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      final taskProvider = context.read<TaskProvider>();

      if (authProvider.token != null) {
        taskProvider.fetchTodos(authProvider.token!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomNavbar(
        onCalendarTap: () async {
          DateTime? selectedDate = await showDatePicker(
            helpText: "Watch The Days",
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (selectedDate != null) {
            print(selectedDate);
          }
        },
        onNotesTap: () {
          print("Notes tapped");
        },
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Color(0xff8ED0FA), Color(0xff3786EB)],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTask()),
              );
            },
            child: const Center(
              child: Icon(Icons.add, size: 30, color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Customappbar(),
              const SizedBox(height: 30),
              Customcard(),
              const SizedBox(height: 20),
              CustomSearchField(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Tasks:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              taskProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xff8ED0FA)))
                  : Column(
                children: taskProvider.activeTasks
                    .map((task) => CustomTask(task: task))
                    .toList(),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Done:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              taskProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xff8ED0FA)))
                  : Column(
                children: taskProvider.doneTasks
                    .map((task) => CustomTask(task: task))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}