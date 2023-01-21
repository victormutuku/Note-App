import 'package:flutter/material.dart';
import 'package:note_app/home.dart';
import 'package:note_app/new_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        NewNote.routeName:(context) => const NewNote(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

