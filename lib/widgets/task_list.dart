import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/widgets/task_list_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskList, child) => ListView(
        children: taskList.tasks.map((Task e) {
          return Column(
            children: [
              TaskListItem(
                e,
              ),
              const Divider(height: 0),
            ],
          );
        }).toList(),
      ),
    );
  }
}
