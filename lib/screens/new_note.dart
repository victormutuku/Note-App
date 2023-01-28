import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../utils/database.dart';
import '../utils/notes.dart';

class NewNote extends StatefulWidget {
  static const routeName = "/newnote";
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  bool runOnce = true;

  @override
  void didChangeDependencies() {
    if (runOnce) {
      final notes = Provider.of<Notes>(context, listen: false);
      final noteId = ModalRoute.of(context)!.settings.arguments;
      if (noteId != null) {
        final foundNote = notes.findById(noteId as String);
        _titleController.text = foundNote['title'];
        _textController.text = foundNote['text'];
      } else {
        return;
      }
    }
    runOnce = false;
    super.didChangeDependencies();
  }

  void _save() {
    final notes = Provider.of<Notes>(context, listen: false);
    final noteId = ModalRoute.of(context)!.settings.arguments;

    if (noteId != null) {
      final foundNote = notes.findById(noteId as String);
      final foundNoteId = foundNote['id'] as String;
      int foundModCount = foundNote['modCount'] as int;

      if (_textController.text.isEmpty && _titleController.text.isEmpty) {
        DatabaseHelper.deleteNote(foundNoteId);
        Navigator.of(context).pushNamed("/");
        return;
      }

      Note note = Note(
        id: foundNoteId,
        title:
            _titleController.text.isEmpty ? "Untitled" : _titleController.text,
        text: _textController.text,
        dateCreated: foundNote['dateCreated'],
        dateModified: DateTime.now().toIso8601String(),
        modCount: foundModCount++,
      );
      DatabaseHelper.updateNote(note);
    } else {
      if (_textController.text.isEmpty && _titleController.text.isEmpty) {
        Navigator.of(context).pushNamed("/");
        return;
      }

      Note note = Note(
        id: DateTime.now().toIso8601String(),
        title:
            _titleController.text.isEmpty ? "Untitled" : _titleController.text,
        text: _textController.text,
        dateCreated: DateTime.now().toIso8601String(),
        dateModified: DateTime.now().toIso8601String(),
        modCount: 0,
      );
      DatabaseHelper.insertNote(note);
    }

    Navigator.of(context).pushNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titleController.text.isNotEmpty
              ? _titleController.text
              : 'Untitled'),
          actions: [
            IconButton(
              onPressed: _save,
              icon: const Icon(Icons.check),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Title"),
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Write here"),
                maxLines: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
