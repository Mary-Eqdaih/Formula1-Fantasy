import 'package:formula1_fantasy/f1/data/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

class NotesDB {
  static late Database _database;
  static String dbPath = "notes.db";
  static String tableName = "notes";
  static String id = "id";
  static String title = "title";
  static String content = "content";
  static String date = "date";
  static String userId = "userId";

  static Future<void> init() async {
    _database = await openDatabase(
      dbPath,
      version: 2, // Incremented version to trigger onUpgrade if needed, but for simplicity here's a clean onCreate
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $title TEXT, $content TEXT, $date TEXT, $userId TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE $tableName ADD COLUMN $userId TEXT DEFAULT ''");
        }
      },
      onOpen: (db) {
        print("Database Opened");
      },
    );
  }

  // CRUD Operations
  // insert Create
  static Future<int> insertNoteToDB(NotesModel note) async {
    int id = await _database.insert(tableName, note.toJson());
    return id;
  }

  static Future<List<NotesModel>> getNoteFromDB(String currentUserId) async {
    var result = await _database.query(
      tableName,
      where: '$userId = ?',
      whereArgs: [currentUserId],
    );
    
    return result.map((map) => NotesModel.fromJson(map)).toList();
  }

  // Delete
  static  deleteNoteFromDB(NotesModel note) async {
    await _database.delete(
      tableName,
      where: '$id = ?',
      whereArgs: [note.id],
    );
  }

  // Update
  static updateNoteFromDB(NotesModel note) async {
    await _database.update(
      tableName,
      note.toJson(),
      where: '$id = ?',
      whereArgs: [note.id],
    );
  }
}
