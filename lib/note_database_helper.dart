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

  Future<void> newNote(note) async {
    final db = await database;
    await db.insert('notes', note);
  }

  Future<void> updateNote(NoteModel note) async {
    final db = await database;
    await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.getId()]);
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NoteModel>> loadNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> noteMaps = await db.query('notes');
    return noteMaps.map((noteMap) => NoteModel.fromMap(noteMap)).toList();
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('notes');
  }

  Future<void> printDB() async {
    final db = await database;
    final List<Map<String, dynamic>> noteMaps = await db.query('notes');
    print(noteMaps);
  }
}