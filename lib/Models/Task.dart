class Task {
  final String id;
  String title;
  DateTime dueDate;
  String Priority;
  bool isDone;
  String? description;
  Task({ required this.id, required this.title, required this.dueDate, this.isDone = false , required this.Priority ,  this.description});
}