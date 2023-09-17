import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> initializeDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'tasksdb.db'),
      onCreate: createDataBase,
      version: 2,
    );
  }

  void createDataBase(Database db, int version) {
    db.execute(
      'CREATE TABLE task(id INTEGER PRIMARY KEY, name TEXT, description TEXT, status TEXT)',
    );
  }

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await initializeDb();
    return _database!;
  }
}
