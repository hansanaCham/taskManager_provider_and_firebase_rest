import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';

import '../widgets/appbar.dart';
import '../widgets/task_list.dart';
import 'package:http/http.dart' as http;

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

  _addTask() async {
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['API_KEY']!;
    print(apiKey);
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$apiKey');
    final body = {
      'email': 'hansanacham@gmail.com',
      'password': 'teatime',
      'returnSecureToken': true,
    };
    final response = await http.post(url, body: body);
    if (response.statusCode != 200) {
      throw Exception('Failed to sign in');
    }
  }

//   _addTask() => Navigator.pushNamed(
//         context,
//         '/addTask',
//       );
}
