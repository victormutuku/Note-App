import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/utils/boxes.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import './screens/new_note.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('Notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Boxes(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          NewNote.routeName: (context) => const NewNote(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
