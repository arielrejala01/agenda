import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  Database? _database;
  static const int version = 1;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'agenda.db'),
      version: version,
      onOpen: (db) async {},
      onCreate: (Database db, int version) async {
        Batch batch = db.batch();

        batch.execute('''
CREATE TABLE agenda(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT NOT NULL,
                    date TEXT NOT NULL,
                    time TEXT NULL,
                    priority INTEGER NOT NULL
                );
        ''');

        await batch.commit();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        Batch batch = db.batch();

        batch.execute('DROP TABLE IF EXISTS agenda');

        batch.execute('''
CREATE TABLE agenda(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT NOT NULL,
                    date TEXT NOT NULL,
                    time TEXT NULL,
                    priority INTEGER NOT NULL
                );
        ''');

        await batch.commit();
      },
    );
  }
}
