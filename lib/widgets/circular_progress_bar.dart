import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: brown,
      ),
    );
  }
}
