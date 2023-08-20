import 'package:flutter/material.dart';
import 'main_page.dart';
import 'add_note_page.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        secondaryHeaderColor: Colors.yellow,
        fontFamily: 'Manrope',
      ),
      home: const MainPage(),
      routes: {
        '/add-note': (context) => const AddNotePage(),
      }
    );
  }
}
