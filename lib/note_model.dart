class NoteModel {

  String title;
  String content;
  DateTime date;

  NoteModel({required this.title, required this.content, required this.date});


  String getTitle() => title;

  String getContent() => content;

  DateTime getDate() => date;

  void setTitle(String title) {
    this.title = title;
  }

  void setContent(String content) {
    this.content = content;
  }

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date.millisecondsSinceEpoch,
    };
  }

  NoteModel.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        content = map['content'],
        date = DateTime.fromMillisecondsSinceEpoch(map['date']);
}