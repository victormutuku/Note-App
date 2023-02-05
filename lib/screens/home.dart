import 'package:flutter/material.dart';
import 'package:note_app/screens/settings.dart';
import 'package:note_app/widgets/circular_progress_bar.dart';
import 'package:provider/provider.dart';

import './new_note.dart';
import '../widgets/notes_grid.dart';
import '../utils/notes.dart';
import '../utils/colors.dart';

enum Selection { edit, settings }

class HomeScreen extends StatelessWidget {
  static const routeName = '/homescreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nnotes = Provider.of<Notes>(context).getNotes();
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: brown),
        title: const Text(
          'Notes',
          style: TextStyle(color: black),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: beige,
            icon: const Icon(
              Icons.more_vert,
              color: brown,
            ),
            position: PopupMenuPosition.under,
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: Selection.settings,
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: Selection.settings,
                child: Text('Settings'),
              ),
            ],
            onSelected: (value) {
              value == Selection.settings
                  ? Navigator.of(context).pushNamed(SettingsScreen.routeName)
                  : Navigator.of(context).pushNamed(NewNote.routeName);
            },
          )
        ],
      ),
      body: Consumer<Notes>(
        builder: (context, notes, _) => notes.fetchedNotes.isEmpty
            ? const CircularProgressBar()
            : const NotesGrid(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(NewNote.routeName),
        backgroundColor: brown,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }
}
