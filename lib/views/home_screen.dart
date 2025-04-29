import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_tile.dart';
import 'add_edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (taskController.taskList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment_late, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  "No tasks yet.\nClick the '+' button to add a task!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (context, index) {
            final task = taskController.taskList[index];
            return TaskTile(
              task: task,
              onEdit: () {
                Get.to(() => AddEditTaskScreen(isEdit: true, task: task));
              },
              onDelete: () {
                taskController.deleteTask(task.id);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddEditTaskScreen(isEdit: false)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
