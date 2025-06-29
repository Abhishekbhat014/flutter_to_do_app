import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/main_home_page.dart';
import 'package:todolist/notification_service.dart';
import 'package:todolist/task_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await TaskDB.init();
  await NotificationService().initNotification();


  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
  await androidImplementation?.requestPermission();

  runApp(
    ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) => MyApp(),
    ),
  );
}

extension on AndroidFlutterLocalNotificationsPlugin? {
  requestPermission() {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "To Do List",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        fontFamily: 'WDXLLubrifontTC',
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      home: MainHomePage(),
    );
  }
}
