  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
import 'package:to_do_list/View/UpdateTask.dart';
import 'package:to_do_list/ViewModels/authProvider.dart';
  import 'package:to_do_list/Widgets/CustomButton.dart';
  import '../ViewModels/TaskProvider.dart';
  import 'package:to_do_list/Models/Task.dart';
  class CustomTask extends StatelessWidget {
    final Task task;

    const CustomTask({super.key, required this.task});

    @override
    Widget build(BuildContext context) {
      final taskProvider = context.read<TaskProvider>();
      final authProvider = context.read<AuthProvider>();
      return Dismissible(
        key: ValueKey(task.id),
        direction: DismissDirection.horizontal,

        // دي أهم حاجة
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // لو Swipe يمين لشمال (مسح)
            if (authProvider.token != null) {
              await taskProvider.deleteTask(task, authProvider.token!);
            }
            return true; // فعل المسح
          } else if (direction == DismissDirection.startToEnd) {
            // لو Swipe شمال ليمين (Edit)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Updatetask(task: task)),
            );
            return false; // ماتمسحش العنصر
          }
          return false;
        },

        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.edit, color: Colors.white, size: 28),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white, size: 28),
        ),

        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showTaskDetails(context, task),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color(0xff8ED0FA),
                  Color(0xff3786EB),
                ],
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: task.completed ?? false,
                  onChanged: (_) async {
                    if (authProvider.token != null) {
                      await taskProvider.toggleTask2(task, authProvider.token!);
                    }
                  },
                  activeColor: Colors.white,
                  checkColor: const Color(0xff3786EB),
                  shape: const CircleBorder(),
                ),
                Text(
                  task.title.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${task.deadline!.day}/${task.deadline!.month}/${task.deadline!.year}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${task.priority} Priority",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
  void _showTaskDetails(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("${task.title} Description is"),
          content: Text(
            task.description ?? "No description",
            style: const TextStyle(fontSize: 14),
          ),
          actions: [
           CustomButton(title: "Close",onPressed: () => Navigator.pop(context),)
            ,
          ],
        );
      },
    );
  }