import 'package:flutter/material.dart';

import '../utils/colors.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.add,
            color: brown,
            size: 30,
          ),
          Text(
            "Add a note",
            style: TextStyle(color: brown, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
