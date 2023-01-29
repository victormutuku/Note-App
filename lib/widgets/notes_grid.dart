import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/notes.dart';
import './note_card.dart';

class NotesGrid extends StatelessWidget {
  final dynamic notes;
  const NotesGrid({required this.notes, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, notes, child) => GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: notes.fetchedNotes.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridTile(
            child: NoteCard(
              id: notes.fetchedNotes[i]['id'],
              title: notes.fetchedNotes[i]['title'],
              text: notes.fetchedNotes[i]['text'],
            ),
          ),
        ),
      ),
    );
  }
}
