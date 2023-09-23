import '../models/task.dart';

abstract class ITaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String taskId);
  initRepository();
}
