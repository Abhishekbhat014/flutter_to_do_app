import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var myBox = Hive.box("toDoListBox");
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _deleteAllTask,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
      ),
      child: Text(
        "Delete all Task",
        style: TextStyle(fontSize: 18, color: Constants.whiteColor),
      ),
    );
  }

  void _deleteAllTask() {
    myBox.deleteAll(myBox.keys);
    setState(() {
    });
  }
}
