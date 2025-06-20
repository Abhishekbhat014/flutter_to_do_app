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
  List<Map<String, dynamic>> activeTask = [];
  List<Map<String, dynamic>> completedTask = [];
  void shiftTask(int index, bool? value) {
    final task = Map<String, dynamic>.from(myBox.getAt(index));
    bool alreadyAdded;
    if (value == true) {
      alreadyAdded = completedTask.any(
        (t) => t["title"] == task["title"] && t["desc"] == task["desc"],
      );
      if (!alreadyAdded) {
        completedTask.add(task);
      }
    }
    if (value == false) {
      alreadyAdded = activeTask.any(
        (t) => t["title"] == task["title"] && t["desc"] == task["desc"],
      );
      if (!alreadyAdded) {
        activeTask.add(task);
      }
    }
    setState(() {});
  }

  void loadTasks() {
    activeTask.clear();
    completedTask.clear();
  
    for (int i = 0; i < myBox.length; i++) {
      final task = Map<String, dynamic>.from(myBox.getAt(i));
      task["key"] = i; // Index store kar rahe update ke liye

      if (task["isChecked"] == true) {
        completedTask.add(task);
      } else {
        activeTask.add(task);
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

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
                    child:
                        activeTask.isEmpty
                            ? Center(
                              child: Text(
                                "No active tasks!",
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                            : ListView.builder(
                              itemCount: activeTask.length,
                              itemBuilder: (context, index) {
                                var task = activeTask[index];
                                var isChecked = task["isChecked"] ?? false;
                                var isFavourite = task["isFavourite"] ?? false;
                                var priority = task["priority"];
                                return Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      color: Constants.whiteColor,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color:
                                              isChecked
                                                  ? Colors.green
                                                  : Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              shape: CircleBorder(),
                                              activeColor: Colors.green,
                                              value: isChecked,
                                              onChanged: (value) {
                                                Map<String, dynamic>
                                                updatedTask =
                                                    Map<String, dynamic>.from(
                                                      task,
                                                    );
                                                updatedTask["isChecked"] =
                                                    value;
                                                myBox.putAt(index, updatedTask);
                                                loadTasks();
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration:
                                                          isChecked
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                      decorationThickness: 3.0,
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
                                            InkWell(
                                              onTap: () {},
                                              child: Icon(
                                                isFavourite
                                                    ? FontAwesomeIcons
                                                        .solidHeart
                                                    : FontAwesomeIcons.heart,
                                                color:
                                                    isFavourite
                                                        ? Colors.red
                                                        : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              task["priority"] ?? "",
                                              style: TextStyle(
                                                color:
                                                    priority == "High"
                                                        ? Colors.deepOrange
                                                        : Colors.black,
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
                    child: Divider(thickness: 2),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                        completedTask.isEmpty
                            ? Center(
                              child: Text(
                                "Not a single task is completed!!!",
                                style: TextStyle(color: Colors.white70),
                              ),
                            )
                            : ListView.builder(
                              itemCount: completedTask.length,
                              itemBuilder: (context, index) {
                                var task = completedTask[index];
                                var isChecked = task["isChecked"] ?? false;
                                var isFavourite = task["isFavourite"] ?? false;
                                var priority = task["priority"];
                                return Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      color: Constants.whiteColor,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color:
                                              isChecked
                                                  ? Colors.green
                                                  : Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              shape: CircleBorder(),
                                              activeColor: Colors.green,
                                              value: isChecked,
                                              onChanged: (value) {
                                                Map<String, dynamic>
                                                updatedTask =
                                                    Map<String, dynamic>.from(
                                                      task,
                                                    );
                                                updatedTask["isChecked"] =
                                                    value;
                                                myBox.putAt(index, updatedTask);
                                                loadTasks();
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration:
                                                          isChecked
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                      decorationThickness: 2.0,
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    isFavourite
                                                        ? FontAwesomeIcons
                                                            .solidHeart
                                                        : FontAwesomeIcons
                                                            .heart,
                                                    color:
                                                        isFavourite
                                                            ? Colors.red
                                                            : Colors.grey,
                                                    size: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  task["priority"] ?? "",
                                                  style: TextStyle(
                                                    color:
                                                        priority == "High"
                                                            ? Colors.deepOrange
                                                            : Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
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
                ],
              ),
    );
  }
}
