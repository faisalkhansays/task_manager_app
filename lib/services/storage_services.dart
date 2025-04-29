import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/task_model.dart';

class StorageService {
  static const String _taskKey = 'tasks';

  // Save tasks to SharedPreferences
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = tasks.map((task) => task.toJson()).toList();
    prefs.setString(_taskKey, json.encode(taskListJson));
  }

  // Load tasks from SharedPreferences
  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskListJson = prefs.getString(_taskKey);

    if (taskListJson == null) {
      return [];
    }

    final List decoded = json.decode(taskListJson);
    return decoded.map((task) => TaskModel.fromJson(task)).toList();
  }
}
