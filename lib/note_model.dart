class NoteModel {

  int? id;
  String title;
  String content;
  DateTime date;

  NoteModel({this.id, required this.title, required this.content, required this.date});

  int getId() => id!;

  String getTitle() => title;

  String getContent() => content;

  DateTime getDate() => date;

  void setTitle(String title) {
    this.title = title;
  }

  void setContent(String content) {
    this.content = content;
  }

  void setDate(DateTime date) {
    this.date = date;
  }

  void update(String title, String content, DateTime date) {
    setTitle(title);
    setContent(content);
    setDate(date);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.millisecondsSinceEpoch,
    };
  }

  NoteModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        content = map['content'],
        date = DateTime.fromMillisecondsSinceEpoch(map['date']);
}