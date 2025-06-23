import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/task_database.dart';

class FavouritePage extends StatefulWidget {
  final List<Map<String, dynamic>> favTasks;

  const FavouritePage({super.key, required this.favTasks});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    TaskDB.init();
    super.initState();
  }

  IconData getIconFromName(String iconName) {
    switch (iconName) {
      case "Office":
        return FontAwesomeIcons.briefcase;
      case "Love":
        return FontAwesomeIcons.heart;
      case "Star":
        return FontAwesomeIcons.star;
      case "Work":
        return FontAwesomeIcons.listUl;
      case "Study":
        return FontAwesomeIcons.bookOpenReader;
      case "Fitness":
        return FontAwesomeIcons.dumbbell;

      default:
        return FontAwesomeIcons.circleQuestion; // fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> favoriteTasks = widget.favTasks;

    return Scaffold(
      backgroundColor: Constants.containerColor,
      body:
          favoriteTasks.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.heartCircleXmark,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No favourites yet!",
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tap the ♡ icon to add a favourite task.",
                      style: TextStyle(fontSize: 16, color: Colors.white54),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoriteTasks.length,
                itemBuilder: (context, index) {
                  final task = favoriteTasks[index];
                  final String title = task["title"];
                  final String desc = task["desc"] ?? '';
                  final String priority = task["priority"];
                  final iconData = getIconFromName(task["icon"]);
                  print(task["icon"]);
                  final DateTime dueDate = DateTime.parse(task["dueDate"]);
                  final formattedDate = DateFormat(
                    'dd MMM yyyy – hh:mm a',
                  ).format(dueDate);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (desc.isNotEmpty) Text(desc),
                          SizedBox(height: 4),
                          Text("Due: $formattedDate"),
                          Text(
                            "Priority: $priority",
                            style: TextStyle(
                              color:
                                  priority == "High"
                                      ? Colors.red
                                      : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(iconData, color: Colors.black54),
                    ),
                  );
                },
              ),
    );
  }
}
