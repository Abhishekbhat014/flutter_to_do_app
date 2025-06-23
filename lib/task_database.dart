import 'package:hive/hive.dart';

class TaskDB {
  static const String boxName = "toDoListBox";
  static late Box myBox;

  static Future<void> initDB() async {
    myBox = await Hive.openBox(boxName);
  }

  static List<Map<String, dynamic>> getTasks() {
    return myBox.values
        .cast<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  static Future<void> addTask(Map<String, dynamic> task) async {
    await myBox.add(task);
  }

  static Future<void> updateTask(
    int index,
    Map<String, dynamic> updatedTask,
  ) async {
    await myBox.putAt(index, updatedTask);
  }

  static Future<void> deleteTask(int index) async {
    await myBox.deleteAt(index);
  }

  static Future<void> clearAllTasks() async {
    await myBox.clear();
  }

  static List<Map<String, dynamic>> getFavouriteTask() {
    return myBox.values
        .cast<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .where((task) => task['isFavourite'] == true)
        .toList();
  }
}
