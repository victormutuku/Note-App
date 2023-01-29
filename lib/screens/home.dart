import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './new_note.dart';
import '../screens/empty_notes.dart';
import '../widgets/notes_grid.dart';
import '../utils/notes.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false).getNotes();

    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        backgroundColor: beige,
        elevation: 0,
        iconTheme: const IconThemeData(color: brown),
        title: const Center(
          child: Text(
            'Notes',
            style: TextStyle(color: black),
          ),
        ),
        actions: [
          PopupMenuButton(
            color: beige,
            icon: const Icon(Icons.more_vert),
            position: PopupMenuPosition.under,
            itemBuilder: (_) => [
              const PopupMenuItem(child: Text('Edit')),
              const PopupMenuItem(child: Text('Settings'))
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: notes,
            builder: (context, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(
                      color: brown,
                    ),
                  )
                : snapshot.data!.isEmpty
                    ? const EmptyNotes()
                    : NotesGrid(notes: notes)
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(NewNote.routeName),
                      backgroundColor: brown,
                      child: const Icon(
                        Icons.add,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
