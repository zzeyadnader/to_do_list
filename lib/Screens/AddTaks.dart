import 'package:flutter/material.dart';
import 'package:to_do_list/Widgets/Button.dart';
import 'package:provider/provider.dart';
import '../Models/TaskProvider.dart';
import '../models/task.dart';
import '../Widgets/CustomText.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _priority = 'High';
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _pickDate() async {
    DateTime initialDate = _selectedDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
        "${picked.day}/${picked.month}/${picked.year}"; // format the date
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 60, left: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_sharp),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Craft Your Task",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181D3F)),
                        ),
                      ],
                    ),
                    Customtext("Task Name"),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xff3786EB),
                            Color(0xff8ED0FA),
                          ],
                        ),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Task Name",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Customtext("Priority"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['High', 'Medium', 'Low'].map((value) {
                        return Container(
                          margin: EdgeInsets.only(right: 10), // spacing between buttons
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _priority == value ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsetsGeometry.only(right: 20),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: value,
                                  groupValue: _priority,
                                  onChanged: (String? selected) {
                                    setState(() {
                                      _priority = selected!;
                                    });
                                  },
                                  activeColor: Colors.white,
                                ),
                                Text(
                                  value,
                                  style: TextStyle(
                                    color: _priority == value ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Customtext("DeadLine Date"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: InputDecoration(
                          hintText: "Choose a date",
                          prefixIcon: const Icon(Icons.calendar_today),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Customtext("Description"),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xff3786EB),
                            Color(0xff8ED0FA),
                          ],
                        ),
                      ),
                      child: TextField(
                        controller: _descController,
                        maxLines: 10,
                        minLines: 10,
                        decoration: InputDecoration(
                          hintText: "Description",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60,),
                    Padding(
                      padding: const EdgeInsets.only(right: 11 , top: 10),
                      child: CustomButton(title: "Add Task" ,onPressed: () {
                        if (_nameController.text.isEmpty || _selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter task name and date")),
                          );
                          return;
                        }

                        Task newTask = Task(
                          title: _nameController.text,
                          dueDate: _selectedDate!,
                          isDone: false,
                          Priority: _priority,
                          description:_descController.text
                        );
                        Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

                        Navigator.pop(context);
                      },
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
