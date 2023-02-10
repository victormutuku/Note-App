import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/utils/colors.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
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

  void _navigateBack() {
    Navigator.of(context).pop();
  }

  void _save() {
    final notes = Provider.of<Notes>(context, listen: false);
    final noteId = ModalRoute.of(context)!.settings.arguments;

    if (noteId != null) {
      final foundNote = notes.findById(noteId as String);
      final foundNoteId = foundNote['id'] as String;
      int foundModCount = foundNote['modCount'] as int;

      if (_textController.text.isEmpty && _titleController.text.isEmpty) {
        _delete();
        _navigateBack();
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

      notes.updateNote(note);
    } else {
      if (_textController.text.isEmpty && _titleController.text.isEmpty) {
        _navigateBack();
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

      notes.insertNote(note);
    }

    _navigateBack();
  }

  void _delete() {
    final notes = Provider.of<Notes>(context, listen: false);
    final noteId = ModalRoute.of(context)!.settings.arguments;

    if (noteId != null) {
      final foundNote = notes.findById(noteId as String);
      final foundNoteId = foundNote['id'] as String;

      notes.deleteNote(foundNoteId);
      _navigateBack();
    } else {
      _navigateBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextField titleTF = TextField(
      controller: _titleController,
      decoration:
          const InputDecoration(border: InputBorder.none, hintText: "Title"),
      style: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: TextInputType.multiline,
      cursorColor: brown,
    );

    List<Widget> actions = [
      IconButton(
        onPressed: _save,
        icon: const Icon(Icons.check),
      ),
      IconButton(
        onPressed: _delete,
        icon: const Icon(Icons.delete),
      )
    ];

    Widget textBody = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _textController,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: "Write here"),
        maxLines: null,
        cursorColor: brown,
        style: TextStyle(fontSize: 20),
      ),
    );

    return Scaffold(
      backgroundColor: beige,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: titleTF,
            actions: actions,
          ),
          SliverToBoxAdapter(
            child: textBody,
          ),
        ],
      ),
    );
  }
}
