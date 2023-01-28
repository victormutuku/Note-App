import 'package:flutter/material.dart';
import 'package:note_app/screens/new_note.dart';

class NoteCard extends StatelessWidget {
  final String id;
  final String title;
  final String text;
  const NoteCard({
    required this.id,
    required this.text,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(NewNote.routeName, arguments: id),
      child: Card(
        key: Key(id),
        color: Colors.lightBlue[100],
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                child: Text(
                  text,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
