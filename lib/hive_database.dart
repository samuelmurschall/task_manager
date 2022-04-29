import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/models/task_model.dart';

class HiveDataBase {
  String boxName = 'task_manager';

  Future<Box> openBox() async {
    Box box = await Hive.openBox<Task>(boxName);
    return box;
  }

  List<Task> getTasks(Box box) {
    return box.values.toList().cast<Task>();
  }

  Future<void> addTask(Box box, Task task) async {
    await box.put(task.id, task);
  }

  Future<void> updateTask(Box box, Task task) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTask(Box box, Task task) async {
    await box.delete(task.id);
  }

  Future<void> deleteAllTasks(Box box) async {
    await box.clear();
  }
}
