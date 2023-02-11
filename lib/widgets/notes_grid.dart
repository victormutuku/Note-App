import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/notes.dart';
import './note_card.dart';
import './selectable_note_card.dart';

class NotesGrid extends StatelessWidget {
  final bool editSelected;
  const NotesGrid(this.editSelected,{super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return OrientationBuilder(
      builder: (context, orientation) => Consumer<Notes>(
        builder: (context, notes, child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: orientation == Orientation.portrait
                  ? deviceWidth / 2
                  : deviceHeight / 2),
          itemCount: notes.fetchedNotes.length,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTile(
              child: editSelected == false ? NoteCard(
                id: notes.fetchedNotes[i]['id'],
                title: notes.fetchedNotes[i]['title'],
                text: notes.fetchedNotes[i]['text'],
              ):SelectableNoteCard(
                id: notes.fetchedNotes[i]['id'],
                title: notes.fetchedNotes[i]['title'],
                text: notes.fetchedNotes[i]['text'],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
