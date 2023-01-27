import 'package:flutter/foundation.dart';
import './database.dart';

class Notes with ChangeNotifier {
  var fetchedNotes = [];
  Future<List> getNotes() async {
    fetchedNotes = await DatabaseHelper.getNotes();
    notifyListeners();
    return fetchedNotes.toList();
  }
}
