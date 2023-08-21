import 'package:flutter/material.dart';
import 'note_database_helper.dart';
import 'add_note_page.dart';
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

  void printDB() async {
    databaseHelper.printDB();
  }

  Route _addPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddNotePage(
        helper: databaseHelper,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOutExpo;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    loadNotes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              databaseHelper.clearDatabase();
              setState(() {
                loadNotes();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              printDB();
            },
          )
        ],
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text('No notes yet'),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(12),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: notes
                  .map((note) => NoteCard(
                        title: note.title,
                        content: note.content,
                        date: note.date,
                      ))
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_addPageRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
