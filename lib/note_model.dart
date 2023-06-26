class NoteModel {

  String title;
  String content;
  DateTime date = DateTime.now();

  NoteModel({required this.title, required this.content});

  String getTitle() => title;

  String getContent() => content;

  DateTime getDate() => date;

  void setTitle(String title) {
    this.title = title;
  }

  void setContent(String content) {
    this.content = content;
  }
}