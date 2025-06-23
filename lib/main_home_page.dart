import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/add_page.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/favourite_page.dart';
import 'package:todolist/home_page.dart';
import 'package:todolist/notification_page.dart';
import 'package:todolist/profile_page.dart';
import 'package:todolist/task_database.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;
  DateTime? pickedDate = DateTime.now();

  List<Widget> get _pages => [
    HomePage(),
    FavouritePage(favTasks: TaskDB.getFavouriteTask()),
    AddPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  String _getDisplayDate(DateTime? date) {
    if (date == null) return "";

    DateTime now = DateTime.now();

    bool isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    if (isToday) {
      return "Today";
    } else {
      return "${date.day.toString().padLeft(2, '0')} ${_getWeekDay(date.weekday)}";
    }
  }

  String _getWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.containerColor,
        actions: [
          Text(
            _getDisplayDate(pickedDate),
            style: TextStyle(color: Constants.whiteColor),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () async {
              pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2025),
                lastDate: DateTime(2100),
              );
              setState(() {});
            },
            child: Icon(
              FontAwesomeIcons.solidCalendarDays,
              color: Constants.whiteColor,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10),
        title: Text(
          "To Do List",
          style: TextStyle(color: Constants.whiteColor),
        ),
      ),
      backgroundColor: Constants.containerColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(45, 48, 72, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: const Color.fromARGB(255, 94, 109, 117),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidHeart),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plus), label: ""),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidBell),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser),
            label: "",
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
