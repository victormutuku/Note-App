import 'package:flutter/material.dart';
import './new_note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Container(),
    );
  }
}
