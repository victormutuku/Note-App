import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static const String notes = "user_notes";

  static Future<Database> initializeDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: ((db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, text TEXT, dateCreated TEXT, dateModified TEXT, modCount INTEGER)');
    }), version: 1);
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await DatabaseHelper.initializeDb();
    return db.query(notes);
  }
}
