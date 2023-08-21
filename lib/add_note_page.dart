import 'package:flutter/material.dart';
import 'package:notes_app/main_page.dart';
import 'package:notes_app/note_database_helper.dart';
import 'note_model.dart';

class AddNotePage extends StatefulWidget {
  final NoteDatabaseHelper? helper;

  const AddNotePage({Key? key, this.helper}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NoteDatabaseHelper? helper = widget.helper;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              var title = titleController.text;
              var content = contentController.text;
              var note = NoteModel(title: title, content: content, date: DateTime.now());
              helper?.newNote(note);
              Navigator.pop(context);
            }
          ),
        ],
      ),
      body: Center(
        child: Form(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    hintText: 'Add a title',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 36,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 1,
                      ),
                    ),
                    disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.brown,
                        width: 3,
                      ),
                    ),
                  ),
                  maxLength: 25,
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
                TextFormField(
                  autofocus: true,
                  maxLines: null,
                  controller: contentController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    border: InputBorder.none,
                    hintText: 'Add some text',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
