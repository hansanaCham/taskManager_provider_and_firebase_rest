import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task.dart';
import 'package:uuid/uuid.dart';
import '../providers/task_provider.dart';
import '../widgets/appbar.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskAppBar("Add New Task", -1),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  // hintText: 'Home Work',
                  labelText: 'Task Name *',
                ),
                controller: _taskNameController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  // hintText: 'Do maths and science home work',
                  labelText: 'Task Description *',
                ),
                controller: _taskDescriptionController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var uuid = const Uuid();
                    final task = Task.noId(
                      name: _taskNameController.text,
                      description: _taskDescriptionController.text,
                      status: "pending",
                    );
                    final tasksProvider =
                        Provider.of<TaskProvider>(context, listen: false)
                            .add(task);
                    Navigator.pop(context);
                  } else {}
                },
                child: const Text('Add Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
