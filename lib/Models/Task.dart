import 'package:hive/hive.dart';

part 'Task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? _id;

  @HiveField(1)
  String? _title;

  @HiveField(2)
  String? _description;

  @HiveField(3)
  String? _priority;

  @HiveField(4)
  bool? _completed;

  @HiveField(5)
  DateTime? _deadline;

  @HiveField(6)
  String? _user;

  @HiveField(7)
  DateTime? _createdAt;

  @HiveField(8)
  DateTime? _updatedAt;

  Task({
    String? id,
    String? title,
    String? description,
    String? priority,
    bool? completed,
    DateTime? deadline,
    String? user,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _priority = priority;
    _completed = completed;
    _deadline = deadline;
    _user = user;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  set id(String? value) => _id = value;
  set title(String? value) => _title = value;
  set description(String? value) => _description = value;
  set priority(String? value) => _priority = value;
  set completed(bool? value) => _completed = value;
  set deadline(DateTime? value) => _deadline = value;
  set user(String? value) => _user = value;
  set createdAt(DateTime? value) => _createdAt = value;
  set updatedAt(DateTime? value) => _updatedAt = value;

  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get priority => _priority;
  bool? get completed => _completed;
  DateTime? get deadline => _deadline;
  String? get user => _user;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      completed: json['completed'],
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      user: json['user'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "priority": priority,
      "completed": completed,
      "deadline": deadline?.toIso8601String(),
      "user": user,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}