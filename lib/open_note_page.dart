import 'package:flutter/material.dart';
import 'note_database_helper.dart';
import 'note_model.dart';

class OpenNotePage extends StatefulWidget {
  final NoteDatabaseHelper? helper;
  final NoteModel note;

  const OpenNotePage({Key? key, this.helper, required this.note}) : super(key: key);

  @override
  State<OpenNotePage> createState() => _OpenNotePageState();
}

class _OpenNotePageState extends State<OpenNotePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.getTitle());
    contentController = TextEditingController(text: widget.note.getContent());
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NoteDatabaseHelper? helper = widget.helper;
    final NoteModel note = widget.note;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              note.update(titleController.text, contentController.text, DateTime.now());
              helper?.updateNote(note);
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

