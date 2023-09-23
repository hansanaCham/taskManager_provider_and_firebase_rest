import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/models/task.dart';
import 'package:task_manager/helpers/firebase_helper.dart';
import 'package:task_manager/interfaces/i_task_interface.dart';

class APITaskRepository implements ITaskRepository {
  final String DATABASEPATH = 'tasks.json';
  final FirebaseHelper api = FirebaseHelper.instance;
  late final String urlDatabase;

  @override
  Future<void> addTask(Task task) async {
    if (urlDatabase.isEmpty) {
      throw Exception('Repository not initialized. Call init() before using.');
    }

    final authToken = api.authToken;

    final databaseResponse = await http.post(
      Uri.parse(urlDatabase),
      body: json.encode(task.toMap()),
    );

    handleResponse(databaseResponse);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final authToken = api.authToken;
    final projectId = api.projectId;
    final url =
        'https://$projectId.firebasedatabase.app/tasks/$taskId.json?auth=$authToken';

    final databaseResponse = await http.delete(
      Uri.parse(url),
    );

    handleResponse(databaseResponse);
  }

  @override
  Future<List<Task>> getTasks() async {
    final authToken = api.authToken;

    final databaseResponse = await http.get(
      Uri.parse(urlDatabase),
    );

    if (databaseResponse.statusCode == 200) {
      final databaseData = json.decode(databaseResponse.body);
      return _parseTasks(databaseData);
    } else {
      throw Exception(
          'Error in fetching data: ${databaseResponse.reasonPhrase}');
    }
  }

  List<Task> _parseTasks(Map<String, dynamic> data) {
    return data.entries.map((entry) {
      final key = entry.key;
      final value = entry.value;
      return Task(
        id: key,
        name: value['name'],
        description: value['description'],
        status: value['status'],
      );
    }).toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    final authToken = api.authToken;
    final projectId = api.projectId;
    final url =
        'https://$projectId.firebasedatabase.app/tasks/${task.id}.json?auth=$authToken';

    final databaseResponse = await http.put(
      Uri.parse(url),
      body: json.encode(task.toMap()),
    );

    handleResponse(databaseResponse);
  }

  void handleResponse(http.Response databaseResponse) {
    print(databaseResponse.statusCode);
    if (databaseResponse.statusCode == 200) {
      // final databaseData = json.decode(databaseResponse.body);
      // print('Data from Firebase Realtime Database: $databaseData');
    } else {
      throw Exception('Failed: ${databaseResponse.reasonPhrase}');
    }
  }

  @override
  initRepository() async {
    await api.initialize();
    await api.authenticate();
    final authToken = api.authToken;
    final projectId = api.projectId;
    urlDatabase =
        'https://$projectId.firebasedatabase.app/$DATABASEPATH?auth=$authToken';
  }
}
