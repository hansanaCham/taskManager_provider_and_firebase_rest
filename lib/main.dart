import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';
import 'package:task_manager/pages/edit_task.dart';
import 'package:task_manager/pages/home.dart';
import 'package:task_manager/pages/new_task.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      //ddf
      // home: Home(),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/addTask': (context) => const NewTaskScreen(),
        '/editTask': (context) => const EditTask(),
      },
    );
  }
}
