import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NoteCard extends StatefulWidget {
  final String id;
  final String title;
  final String text;
  final bool isSelecting;
  final bool isSelected;
  final Function()? onTap;
  final Function()? onLongPress;
  const NoteCard({
    required this.id,
    required this.text,
    required this.title,
    this.isSelecting = false,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  State<NoteCard> createState() => NoteCardState();
}

class NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    var normalTile = ListTile(
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        widget.text,
        style: const TextStyle(color: brown),
        overflow: TextOverflow.clip,
      ),
    );
    var selectionTile = ListTile(
      leading: widget.isSelected
          ? Icon(Icons.check_box)
          : Icon(Icons.check_box_outline_blank),
      minLeadingWidth: 5,
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        widget.text,
        style: const TextStyle(color: brown),
        overflow: TextOverflow.clip,
      ),
    );
    return InkWell(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Card(
        key: Key(widget.id),
        color: lightbeige,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: widget.isSelecting ? selectionTile : normalTile,
        ),
      ),
    );
  }
}
