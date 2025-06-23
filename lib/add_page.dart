import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/task_database.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  DateTime? _dueDate;
  String _priority = 'Normal';
  String _selectedIconKey = "Work";
  TimeOfDay? _dueTime;

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Constants.containerColor,
              hourMinuteTextColor: Colors.white,
              dialHandColor: Colors.blueAccent,
            ),
            colorScheme: ColorScheme.dark(
              primary: Colors.blueAccent,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dueTime = picked;
      });
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              surface: Constants.containerColor,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Constants.containerColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _saveTask() async {
    if (_taskController.text.trim().isEmpty) {
      Get.snackbar(
        "Missing Field",
        "Task title is mandatory!",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (_dueDate == null || _dueTime == null) {
      Get.snackbar(
        "Missing Field",
        "Please select both date and time!",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    DateTime dueDateTime = DateTime(
      _dueDate!.year,
      _dueDate!.month,
      _dueDate!.day,
      _dueTime!.hour,
      _dueTime!.minute,
    );

    Map<String, dynamic> task = {
      "title": _taskController.text.trim(),
      "desc": _descController.text.trim(),
      "priority": _priority,
      "dueDate": dueDateTime.toIso8601String(),
      "isCompleted": false,
      "isFavourite": false,
      "icon": _selectedIconKey,
    };

    await TaskDB.addTask(task);

    Get.snackbar(
      "Success",
      "Task added successfully!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    _taskController.clear();
    _descController.clear();
    _priority = "Normal";
    _selectedIconKey = "Work";
    _dueDate = null;
    _dueTime = null;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.containerColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Title",
                style: TextStyle(fontSize: 16, color: Constants.whiteColor),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: "Enter task name...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Description (optional)",
                style: TextStyle(fontSize: 16, color: Constants.whiteColor),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write something...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Due Date",
                style: TextStyle(fontSize: 16, color: Constants.whiteColor),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dueDate == null
                            ? "Select a date"
                            : DateFormat('dd MMM, yyyy').format(_dueDate!),
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Due Time",
                style: TextStyle(fontSize: 16, color: Constants.whiteColor),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: _pickTime,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _dueTime == null
                            ? "Select time"
                            : _dueTime!.format(context), // 08:30 PM format
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(Icons.access_time, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Priority",
                style: TextStyle(fontSize: 16, color: Constants.whiteColor),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _priority,
                items:
                    ["Low", "Normal", "High"]
                        .map(
                          (val) =>
                              DropdownMenuItem(value: val, child: Text(val)),
                        )
                        .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _priority = val);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),

              Text(
                "Icon",
                style: TextStyle(fontSize: 16, color: Constants.whiteColor),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedIconKey,
                hint: Text("Select Icon"),
                items:
                    iconOptions.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Row(
                          children: [
                            Icon(entry.value, size: 20),
                            SizedBox(width: 8),
                            Text(entry.key),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIconKey = value!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    "Save Task",
                    style: TextStyle(fontSize: 18, color: Constants.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
