import 'package:flutter/material.dart';
import 'package:note_app/screens/settings.dart';
import 'package:note_app/utils/color_schemes.g.dart';
import 'package:note_app/utils/notes.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import './screens/new_note.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Notes(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: lightColorScheme,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          NewNote.routeName: (context) => const NewNote(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        },
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
      ),
    );
  }
}
