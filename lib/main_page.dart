import 'package:flutter/material.dart';
import 'note_database_helper.dart';
import 'add_note_page.dart';
import 'open_note_page.dart';
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

  Offset tapPosition = Offset.zero;

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

  Route _openNoteRoute(NoteModel note) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OpenNotePage(
        note: note,
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

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showPopupMenu(BuildContext context, NoteModel note) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    await showMenu(
        context: context,
        position: RelativeRect.fromRect(
          Rect.fromLTWH(tapPosition.dx, tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height),
        ),
        items: [
          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete Note'),
          )
        ]).then(
      (selectedValue) {
        if (selectedValue == 'delete') {
          databaseHelper.deleteNote(note.getId());
        }
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
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Delete notes'),
                content:
                    const Text('Are you sure you want to delete all notes?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      databaseHelper.clearDatabase();
                      setState(() {
                        loadNotes();
                      });
                      Navigator.pop(context, 'Delete');
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
              children: notes.map(
                (note) {
                  return Builder(
                    builder: (BuildContext cardContext) {
                      return InkWell(
                        onTapDown: (details) {
                          _getTapPosition(details);
                        },
                        onTap: () {
                          Navigator.of(context).push(_openNoteRoute(note));
                        },
                        onLongPress: () {
                          _showPopupMenu(cardContext, note);
                        },
                        child: NoteCard(
                          title: note.getTitle(),
                          content: note.getContent(),
                          date: note.getDate(),
                        ),
                      );
                    },
                  );
                },
              ).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(_addPageRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
