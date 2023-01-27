import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './new_note.dart';
import '../widgets/note_card.dart';
import '../utils/notes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false).getNotes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(NewNote.routeName),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: notes,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !snapshot.hasData
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.grey[700],
                          size: 30,
                        ),
                        Text(
                          "Add a note",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 20),
                        ),
                      ],
                    ),
                  )
                : Consumer<Notes>(
                    builder: (context, notes, child) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: notes.fetchedNotes.length,
                      itemBuilder: ((context, i) => GridTile(
                            child: NoteCard(
                              title: notes.fetchedNotes[i]['title'],
                              text: notes.fetchedNotes[i]['text'],
                            ),
                          )),
                    ),
                  ),
      ),
    );
  }
}
