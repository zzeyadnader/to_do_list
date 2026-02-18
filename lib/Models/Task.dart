import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  String priority;

  @HiveField(5)
  String description;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.isDone = false,
    required this.priority,
    required this.description,
  });
}