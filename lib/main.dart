import 'package:flutter/material.dart';
import 'main_page.dart';

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
        fontFamily: 'Manrope',
      ),
      home: const MainPage(),
    );
  }
}
