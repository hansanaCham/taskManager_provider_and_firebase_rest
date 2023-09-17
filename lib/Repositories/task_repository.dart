import 'package:sqflite/sqflite.dart';

import '../helpers/database_helper.dart';
import '../models/task.dart';

class TaskRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  TaskRepository() {}

  initRepository() async {
    await _databaseHelper.initializeDb();
  }

  Future<List<Task>> getTasks() async {
    final db = await _databaseHelper.db;
    final List<Map<String, dynamic>> maps = await db.query('task');
    return List.generate(maps.length, (index) {
      return Task(
          id: maps[index]['id'],
          name: maps[index]['name'],
          description: maps[index]['description'],
          status: maps[index]['status']);
    });
  }

  Future<void> addTask(Task task) async {
    final db = await _databaseHelper.db;
    await db.insert(
      'task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    final db = await _databaseHelper.db;
    await db.update(
      'task',
      task.toMap(),
      where: 'id=?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int taskId) async {
    final db = await _databaseHelper.db;
    await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
