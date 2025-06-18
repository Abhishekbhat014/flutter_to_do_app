import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/add_page.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/favourite_page.dart';
import 'package:todolist/home_page.dart';
import 'package:todolist/notification_page.dart';
import 'package:todolist/profile_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FavouritePage(),
    AddPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.containerColor,
        actions: [
          InkWell(
            onTap: () {},
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: InkWell(
              onTap: () async {},
              child: Icon(
                FontAwesomeIcons.solidCalendarDays,
                color: Constants.whiteColor,
              ),
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
            backgroundColor: Color.fromRGBO(45, 48, 72, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidHeart),
            label: "",
            backgroundColor: Color.fromRGBO(45, 48, 72, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plus),
            label: "",
            backgroundColor: Color.fromRGBO(45, 48, 72, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidBell),
            label: "",
            backgroundColor: Color.fromRGBO(45, 48, 72, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidUser),
            label: "",
            backgroundColor: Color.fromRGBO(45, 48, 72, 1),
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
