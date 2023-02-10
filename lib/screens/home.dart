import 'package:flutter/material.dart';
import 'package:note_app/screens/empty_notes.dart';
import 'package:note_app/screens/settings.dart';
import 'package:note_app/widgets/circular_progress_bar.dart';
import 'package:provider/provider.dart';

import './new_note.dart';
import '../widgets/notes_grid.dart';
import '../utils/notes.dart';
import '../utils/colors.dart';

enum Selection { edit, settings }

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  bool _editSelected = false;

  @override
  Widget build(BuildContext context) {
    _isLoading = true;
    final nnotes = Provider.of<Notes>(context).getNotes();
    _isLoading = false;
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: brown),
        title: Text(
          _editSelected == false ? 'Notes' : 'Selected',
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
                value: Selection.edit,
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: Selection.settings,
                child: Text('Settings'),
              ),
            ],
            onSelected: (value) {
              if (value == Selection.settings) {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              } else {
                setState(() {
                  _editSelected = !_editSelected;
                });
              }
            },
          )
        ],
      ),
      body: Consumer<Notes>(
        builder: (context, notes, _) => notes.fetchedNotes.isEmpty
            ? const EmptyNotes()
            : _isLoading
                ? CircularProgressBar()
                : NotesGrid(_editSelected),
      ),
      floatingActionButton: _editSelected == false
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(NewNote.routeName),
              backgroundColor: brown,
              child: const Icon(
                Icons.add,
                color: white,
              ),
            )
          : FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(NewNote.routeName),
              backgroundColor: red,
              child: const Icon(
                Icons.delete,
                color: white,
              ),
            ),
    );
  }
}
