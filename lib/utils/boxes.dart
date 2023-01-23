import 'package:flutter/foundation.dart';
import 'package:note_app/models/note.dart';

class Boxes with ChangeNotifier {

  List<Note> getNotes() {
    List<Note> fetched = [];

    if (fetched.isEmpty) {
      return [];
    } else {
      return fetched;
    }
  }

  void closeBoxes() {
    // Hive.close();
  }
}
