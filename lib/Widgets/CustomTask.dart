  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:to_do_list/Widgets/CustomButton.dart';
  import '../ViewModels/TaskProvider.dart';
  import 'package:to_do_list/Models/Task.dart';
  class CustomTask extends StatelessWidget {
    final Task task;

    const CustomTask({super.key, required this.task});

    @override
    Widget build(BuildContext context) {
      return Dismissible(
        key: ValueKey(task.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<TaskProvider>(context, listen: false).deleteTask(task);
        },
        background: Container(
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
              hoverColor: Colors.transparent, // مهم للويب
              focusColor: Colors.transparent, // مهم للكيبورد
              borderRadius: BorderRadius.circular(20),
          onTap: () {
            _showTaskDetails(context, task);
          },
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
                  value: task.isDone,
                  onChanged: (_)  {
                    context.read<TaskProvider>().toggleTask(task);
                  },
                  activeColor: Colors.white,
                  checkColor: const Color(0xff3786EB),
                  shape: const CircleBorder(),
                ),
                Text(
                  task.title,
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
                      "${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}",
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