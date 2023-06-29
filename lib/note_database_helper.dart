import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'note_model.dart';

class NoteDatabaseHelper {
  static final NoteDatabaseHelper instance = NoteDatabaseHelper._init();

  static Database? _database;

  NoteDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, date EPOCH)');
      }
    );
  }

  Future<void> saveNotes(List<NoteModel> notes) async {
    final db = await database;
    await db.delete('notes');
    for (var note in notes) {
      await db.insert('notes', note.toMap());
    }
  }

  Future<List<NoteModel>> loadNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> noteMaps = await db.query('notes');
    return noteMaps.map((noteMap) => NoteModel.fromMap(noteMap)).toList();
  }


}