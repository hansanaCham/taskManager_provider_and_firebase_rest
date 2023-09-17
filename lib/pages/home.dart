import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';

import '../widgets/appbar.dart';
import '../widgets/task_list.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskList, child) {
        return Scaffold(
            appBar: TaskAppBar("Task Manager", taskList.tasks.length),
            body: const TaskListView(),
            floatingActionButton: child);
      },
      child: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  _addTask() => Navigator.pushNamed(
        context,
        '/addTask',
      );
}
