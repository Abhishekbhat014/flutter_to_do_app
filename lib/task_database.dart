import 'package:hive/hive.dart';

class TaskDB {

  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox("toDoListBox");
  }

  static Box get myBox => _box;

  static Future<void> addTask(Map<String, dynamic> task) async {
    await _box.add(task);
  }

  static List<Map<String, dynamic>> getAllTasks() {
    return _box.values
        .cast<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static List<Map<String, dynamic>> getFavouriteTask() {
    return _box.values
        .cast<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .where((task) => task['isFavourite'] == true)
        .toList();
  }
}
