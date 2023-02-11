import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../widgets/circular_progress_bar.dart';
import '../widgets/note_card.dart';
import './new_note.dart';
import '../utils/notes.dart';
import '../utils/colors.dart';
import 'empty_notes.dart';
import 'settings.dart';

enum Selection { edit, settings }

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false, isSelecting = false, selectAll = false;
  List<Selectable<String>?> selectables = [], listedNotes = [];

  void onNoteSelected(int i) {
    setState(() {
      listedNotes[i]!.isSelected = !listedNotes[i]!.isSelected;
      if (listedNotes[i]!.isSelected) {
        selectables.add(listedNotes[i]);
      } else {
        selectables.remove(listedNotes[i]);
      }
    });
  }

  void onSelectedAll() {
    setState(() {
      selectAll = !selectAll;
      for (final note in listedNotes) {
        note!.isSelected = true;
        selectables.add(note);
      }
    });
  }

  void onUnSelectedAll() {
    setState(() {
      selectAll = !selectAll;
      for (final note in listedNotes) {
        note!.isSelected = false;
        selectables.remove(note);
      }
    });
  }

  Widget build(BuildContext context) {
    Provider.of<Notes>(context).getNotes();
    Size size = MediaQuery.of(context).size;
    FloatingActionButton fab = FloatingActionButton(
      onPressed: () => Navigator.of(context).pushNamed(NewNote.routeName),
      backgroundColor: isSelecting ? red : brown,
      child: Icon(
        isSelecting ? Icons.delete : Icons.add,
        color: white,
      ),
    );
    var selectionActions = [
      TextButton(
        onPressed: onSelectedAll,
        child: Text(
          'Select All',
          style: TextStyle(color: black),
        ),
      ),
      TextButton(
        onPressed: onUnSelectedAll,
        child: Text(
          'Unselect',
          style: TextStyle(color: black),
        ),
      ),
      IconButton(
        onPressed: () => setState(() => isSelecting = !isSelecting),
        icon: const Icon(Icons.cancel),
      ),
    ];

    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: brown),
        title: Text(
          isSelecting ? 'Select Notes' : 'Notes',
          style: TextStyle(color: black),
        ),
        centerTitle: !isSelecting,
        actions: isSelecting
            ? selectionActions
            : [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SettingsScreen.routeName);
                  },
                  icon: const Icon(Icons.settings),
                )
              ],
      ),
      body: Consumer<Notes>(
        builder: (context, notes, _) {
          for (final note in notes.fetchedNotes) {
            listedNotes.add(Selectable<String>(note['id'], false));
          }
          var notesGrid = OrientationBuilder(
            builder: (context, orientation) => Consumer<Notes>(
              builder: (context, notes, child) => GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: orientation == Orientation.portrait
                        ? size.width / 2
                        : size.height / 2),
                itemCount: notes.fetchedNotes.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridTile(
                    child: NoteCard(
                      id: notes.fetchedNotes[i]['id'],
                      title: notes.fetchedNotes[i]['title'],
                      text: notes.fetchedNotes[i]['text'],
                      isSelected: listedNotes[i]!.isSelected,
                      isSelecting: isSelecting,
                      onTap: () {
                        if (isSelecting) {
                          onNoteSelected(i);
                        } else {
                          Navigator.of(context).pushNamed(
                            NewNote.routeName,
                            arguments: notes.fetchedNotes[i]['id'],
                          );
                        }
                      },
                      onLongPress: () =>
                          setState(() => isSelecting = !isSelecting),
                    ),
                  ),
                ),
              ),
            ),
          );

          return notes.fetchedNotes.isEmpty
              ? const EmptyNotes()
              : isLoading
                  ? CircularProgressBar()
                  : notesGrid;
        },
      ),
      floatingActionButton: fab,
    );
  }
}
