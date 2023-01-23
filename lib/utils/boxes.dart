import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:note_app/models/note.dart';

class Boxes with ChangeNotifier {
  static Box<Note> openNotes = Hive.box<Note>('Notes');

  List<Note> getNotes() {
    List<Note> fetched = openNotes.values.toList();

    if (fetched.isEmpty) {
      return [];
    } else {
      return fetched;
    }
  }

  void closeBoxes() {
    Hive.close();
  }
}
