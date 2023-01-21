import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './screens/home.dart';
import './screens/new_note.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Notes');
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
        NewNote.routeName: (context) => const NewNote(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
