import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import './database.dart';

class Notes with ChangeNotifier {
  var fetchedNotes = [];

  dynamic findById(String id) {
    if (fetchedNotes.isNotEmpty) {
      for (var element in fetchedNotes) {
        if (element['id'] == id) {
          return element;
        } else {
          continue;
        }
      }
    }
  }
  
  Future<List> getNotes() async {
    fetchedNotes = await DatabaseHelper.getNotes();

    notifyListeners();
    return fetchedNotes.toList();
  }

  Future<void> insertNote(Note note) async {
    final Map<String, Object> noteData = {
      'id': note.id,
      'title': note.title,
      'text': note.text,
      'dateCreated': note.dateCreated,
      'dateModified': note.dateModified,
      'modCount': note.modCount,
    };

    final db = await DatabaseHelper.initializeDb();
    db.insert(
      DatabaseHelper.notes,
      noteData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    final Map<String, Object> noteData = {
      'id': note.id,
      'title': note.title,
      'text': note.text,
      'dateCreated': note.dateCreated,
      'dateModified': note.dateModified,
      'modCount': note.modCount,
    };

    final db = await DatabaseHelper.initializeDb();
    db.update(DatabaseHelper.notes, noteData,
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'id = ?',
        whereArgs: [note.id]);
    notifyListeners();
  }

  Future<void> deleteNote(String noteId) async {
    final db = await DatabaseHelper.initializeDb();
    db.delete(DatabaseHelper.notes, where: 'id = ?', whereArgs: [noteId]);
    notifyListeners();
  }
}
