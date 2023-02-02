import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: beige,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 26),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container());
  }
}
