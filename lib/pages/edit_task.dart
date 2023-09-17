import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/appbar.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  late String taskName;
  late String description;
  late String status;
  late int id;

  @override
  void didChangeDependencies() {
    Task task = ModalRoute.of(context)!.settings.arguments as Task;
    status = task.status;
    taskName = task.name;
    description = task.description;
    id = task.id;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Task task = ModalRoute.of(context)!.settings.arguments as Task;
    // status = task.status;
    return Scaffold(
      appBar: const TaskAppBar("Upate", -1),
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
                initialValue: taskName,
                onChanged: (value) => setState(() {
                  taskName = value;
                }),

                // controller: _taskNameController,
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
                initialValue: description,
                onChanged: (value) => setState(() {
                  description = value;
                }),
                // controller: _taskDescriptionController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          status = "pending";
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: (status == "pending")
                              ? Colors.green[200]
                              : Colors.white,
                          foregroundColor: Colors.black
                          // use a custom color
                          ),
                      child: const Text("Pending")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        status = "done";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: (status == "done")
                            ? Colors.green[200]
                            : Colors.white,
                        foregroundColor: Colors.black
                        // use a custom color
                        ),
                    child: const Text("Done"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // print(task);
                    final tsk = Task(
                      id: id,
                      name: taskName,
                      description: description,
                      status: status,
                    );
                    final tasksProvider =
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(tsk);
                    Navigator.pop(context);
                  } else {}
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, foregroundColor: Colors.black
                    // use a custom color
                    ),
                child: const Text('Update Task'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
