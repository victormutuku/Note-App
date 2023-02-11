import 'package:flutter/material.dart';
import 'package:note_app/screens/new_note.dart';
import 'package:note_app/utils/colors.dart';

class SelectableNoteCard extends StatefulWidget {
  final String id;
  final String title;
  final String text;
  SelectableNoteCard({
    required this.id,
    required this.text,
    required this.title,
    super.key,
  });

  @override
  State<SelectableNoteCard> createState() => _SelectableNoteCardState();
}

class _SelectableNoteCardState extends State<SelectableNoteCard> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(NewNote.routeName, arguments: widget.id),
      child: Stack(
        children: [
          Card(
            key: Key(widget.id),
            color: lightbeige,
            elevation: 5,
            child: Container(
              color: _checked == true ? brown.withOpacity(0.2) : null,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.title,
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
                      widget.text,
                      style: const TextStyle(color: brown),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Checkbox(
            side: BorderSide(color: brown, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
            ),
            value: _checked,
            onChanged: (value) {
              setState(() {
                _checked = !_checked;
              });
            },
          )
        ],
      ),
    );
  }
}
