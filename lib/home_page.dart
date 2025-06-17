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
              : ListView.builder(
                itemCount: myBox.length,
                itemBuilder: (context, index) {
                  var task = myBox.getAt(index);
                  return Column(
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Constants.whiteColor,
                        child: ListTile(
                          title: Text(
                            task["title"] ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            task["desc"] ?? "",
                            style: TextStyle(color: Colors.black87),
                          ),
                          trailing: Text(
                            task["priority"] ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      
    );
  }
}
