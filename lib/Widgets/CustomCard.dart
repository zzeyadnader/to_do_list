import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/TaskProvider.dart';
class Customcard extends StatelessWidget {
  const Customcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xff3786EB),
            Color(0xff8ED0FA),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  int totalTasks = taskProvider.activeTasks.length + taskProvider.doneTasks.length;
                  int doneTasks = taskProvider.doneTasks.length;
                  double progress = totalTasks == 0 ? 0 : doneTasks / totalTasks;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 7),
                        child: const Text(
                          "Today's Progress",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "$totalTasks Tasks",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Progress",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${(progress * 100).toInt()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: Container(
                          height: 10,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress, // dynamic progress
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );

  }
}
