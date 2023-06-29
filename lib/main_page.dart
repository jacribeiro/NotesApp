import 'package:flutter/material.dart';
import 'package:notes_app/note_database_helper.dart';
import 'note_model.dart';
import 'note_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NoteDatabaseHelper databaseHelper = NoteDatabaseHelper.instance;
  List<NoteModel> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    List<NoteModel> loadedNotes = await databaseHelper.loadNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: notes.isEmpty
        ? const Center(
          child: Text('No notes yet'),
        )
        : 
        GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: notes.map((note) => NoteCard(
            key: ValueKey(note.id),
            title: note.title,
            content: note.content,
            date: note.date,
          )).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
    );
  }
}