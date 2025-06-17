import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:todolist/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myBox = Hive.box("toDoListBox");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.containerColor,
      body:
          myBox.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.clipboardList,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No tasks yet!",
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tap the + icon below to add a task.",
                      style: TextStyle(fontSize: 16, color: Colors.white54),
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: myBox.length,
                      itemBuilder: (context, index) {
                        var task = myBox.getAt(index);
                        var isCompleted = task["isCompleted"] ?? false;
                        return Column(
                          children: [
                            Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              color: Constants.whiteColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      isCompleted ? Colors.green : Colors.white,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      shape: CircleBorder(),
                                      activeColor: Colors.green,
                                      value: isCompleted,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          var updatedTask =
                                              Map<String, dynamic>.from(task);
                                          updatedTask["isCompleted"] = value!;
                                          myBox.putAt(index, updatedTask);
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task["title"] ?? "",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  isCompleted
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            task["desc"] ?? "",
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      task["priority"] ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Completed task will be placed here...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
    );
  }
}
