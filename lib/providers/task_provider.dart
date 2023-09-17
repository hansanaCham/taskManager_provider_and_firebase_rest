import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:task_manager/helpers/database_helper.dart';
import 'package:task_manager/models/task.dart';

import '../Repositories/task_repository.dart';

class TaskProvider extends ChangeNotifier {
  late TaskRepository _taskRepository;
  List<Task> _tasks = [];

  TaskProvider() {
    _taskRepository = TaskRepository();
    _init();
  }

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  Future<void> _init() async {
    await _taskRepository.initRepository();
    _tasks = await _taskRepository.getTasks();
    notifyListeners();
  }

  updateTask(Task task) async {
    await _taskRepository.updateTask(task);
    _tasks = await _taskRepository.getTasks();
    notifyListeners();
  }

  deleteFromList(Task task) async {
    await _taskRepository.deleteTask(task.id);
    _tasks = await _taskRepository.getTasks();
    notifyListeners();
  }

  add(Task task) async {
    // _tasks.add(task);
    await _taskRepository.addTask(task);
    _tasks = await _taskRepository.getTasks();
    notifyListeners();
  }
}
