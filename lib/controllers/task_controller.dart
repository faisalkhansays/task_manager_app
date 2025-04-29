import 'package:get/get.dart';
import '../model/task_model.dart';
import 'package:uuid/uuid.dart';
import '../services/storage_services.dart';

class TaskController extends GetxController {
  final StorageService _storageService = StorageService();

  var taskList = <TaskModel>[].obs;

  @override
  void onInit() {
    loadTasks();
    super.onInit();
  }

  void addTask(String title, String description, DateTime date) {
    final task = TaskModel(
      id: const Uuid().v4(), // generates a unique id
      title: title,
      description: description,
      date: date,
    );
    taskList.add(task);
    saveTasks();
    Get.snackbar('Task Added', 'Your task has been added successfully!',
        snackPosition: SnackPosition.BOTTOM);
  }

  void updateTask(String id, String title, String description, DateTime date) {
    final index = taskList.indexWhere((task) => task.id == id);
    if (index != -1) {
      taskList[index] =
          TaskModel(id: id, title: title, description: description, date: date);
      saveTasks();
      Get.snackbar('Task Updated', 'Your task has been updated successfully!',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void deleteTask(String id) {
    taskList.removeWhere((task) => task.id == id);
    saveTasks();
    Get.snackbar('Task Deleted', 'The task has been deleted successfully!',
        snackPosition: SnackPosition.BOTTOM);
  }

  void loadTasks() async {
    final tasks = await _storageService.loadTasks();
    taskList.assignAll(tasks);
  }

  void saveTasks() {
    _storageService.saveTasks(taskList);
  }
}
