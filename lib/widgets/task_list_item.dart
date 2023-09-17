import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  const TaskListItem(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(task.id),
      onDismissed: (direction) {
        _deleteFromList(task, context);
      },
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
      child: ListTile(
        title: Text(task.name),
        subtitle: Text(task.description),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(task.status),
              Checkbox(
                value: task.status == "done" ? true : false,
                onChanged: (value) => _done(task, context),
              ),
            ],
          ),
        ),
        dense: true,
        onLongPress: () => {
          Navigator.pushNamed(
            context,
            '/editTask',
            arguments: task,
          )
        },
      ),
    );
  }

  _done(Task task, BuildContext context) {
    final tasksProvider = Provider.of<TaskProvider>(context, listen: false);
    final newTask = Task(
        id: task.id,
        name: task.name,
        description: task.description,
        status: task.status == "pending" ? "done" : "pending");

    tasksProvider.updateTask(newTask);
  }

  _deleteFromList(Task task, BuildContext context) {
    final tasksProvider = Provider.of<TaskProvider>(context, listen: false);
    tasksProvider.deleteFromList(task);
  }
}
