import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MuleSoft.db";
  static const _databaseVersion = 1;
  // Table Name
  static const table = 'Movies';
  // Attributes
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnActor = 'actor';
  static const columnActress = 'actress';
  static const columnDirector = 'director';
  static const columnYor = 'yor';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // Takes time to Init DB when accessed First time
    _database = await _initDatabase();
    return _database;
  }

  // Opens DB(If not exist, Creates)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnActor TEXT NOT NULL,
            $columnActress TEXT NOT NULL,
            $columnDirector TEXT NOT NULL,
            $columnYor INTEGER NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database
  void insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    await db?.insert(table, row);
    print("Insert");
  }

  // All of the rows are returned as a list of maps
  Future<List<Map<String, Object?>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }
}
