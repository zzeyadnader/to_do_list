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

  set id(String value) {
    _id = value;
  }


  set title(String value) {
    _title = value;
  }

  set description(String value) {
    _description = value;
  }

  set priority(String value) {
    _priority = value;
  }

  set completed(bool value) {
    _completed = value;
  }

  set deadline(DateTime value) {
    _deadline = value;
  }

  set user(String value) {
    _user = value;
  }

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  DateTime? get updatedAt => _updatedAt;

  DateTime? get createdAt => _createdAt;

  String? get user => _user;

  DateTime? get deadline => _deadline;

  bool? get completed => _completed;

  String? get priority => _priority;

  String? get description => _description;

  String? get title => _title;

  String? get id => _id;
}