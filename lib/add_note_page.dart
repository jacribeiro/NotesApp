import 'package:flutter/material.dart';
import 'package:notes_app/note_database_helper.dart';

class AddNotePage extends StatefulWidget {
  final NoteDatabaseHelper? helper;

  const AddNotePage({Key? key, this.helper}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  bool bulletPressed = false;

  @override
  void initState() {
    super.initState();
    contentController.addListener(bulletOption);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.removeListener(bulletOption);
    contentController.dispose();
    super.dispose();
  }

  void bulletOption() {
    final text = contentController.text;
    final lastChar = text.isNotEmpty ? text[text.length - 1] : "";

    if (bulletPressed) {
      if (lastChar == '\n') {
        putBullet();
      }
    }
  }

  void putBullet() {
    final text = contentController.text;
    contentController.text = '$text\u2022';
    contentController.selection = TextSelection.collapsed(offset: text.length + 1);
  }

  @override
  Widget build(BuildContext context) {
    final NoteDatabaseHelper? helper = widget.helper;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              print(contentController.selection.baseOffset);
            }
          ),
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                var title = titleController.text;
                var content = contentController.text;
                var note = {
                  'title': title,
                  'content': content,
                  'date': DateTime.now().millisecondsSinceEpoch,
                };
                helper?.newNote(note);
                Navigator.pop(context);
              }),
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
                    contentPadding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
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
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    maxLines: null,
                    controller: contentController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
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
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    color: Colors.brown.shade700,
                  ))),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.format_list_bulleted),
                        color: bulletPressed
                            ? Colors.brown.shade100
                            : Colors.brown.shade700,
                        onPressed: () {
                          setState(
                            () {
                              bulletPressed = !bulletPressed;
                              if (bulletPressed) {
                                putBullet();
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        icon: const Icon(Icons.check_box_outlined),
                        color: Colors.brown.shade700,
                        onPressed: () {},
                      )
                    ],
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
