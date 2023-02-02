import 'package:flutter/material.dart';
import 'package:note_app/screens/new_note.dart';
import 'package:note_app/utils/colors.dart';

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
        color: lightbeige,
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
                        // color: brown,
                      ),
                    ),
                  )
                ],
              ),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(color: brown),
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
