import 'package:flutter/material.dart';
import 'package:note_app/utils/boxes.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import './screens/new_note.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    Provider.of<Boxes>(context).closeBoxes();
    super.dispose();
  }

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
