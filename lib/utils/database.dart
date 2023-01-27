import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import '../models/note.dart';

class DatabaseHelper {
  static const String _notes = "user_notes";

  static Future<Database> _initializeDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'notes.db'),
        onCreate: ((db, version) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, text TEXT, dateCreated TEXT, dateModified TEXT, modCount INTEGER)');
    }), version: 1);
  }

  static Future<void> insertNote(Note note) async {
    final Map<String, Object> noteData = {
      'id': note.id,
      'title': note.title,
      'text': note.text,
      'dateCreated': note.dateCreated,
      'dateModified': note.dateModified,
      'modCount': note.modCount,
    };

    final db = await DatabaseHelper._initializeDb();
    db.insert(_notes, noteData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await DatabaseHelper._initializeDb();
    return db.query(_notes);
  }
}
