import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

const INIT_SQL_QUERIES = [
  'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT NOT NULL, image TEXT, latitude REAL, longtitude REAL, address TEXT)'
];

class DB {
  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final dbHandle = await DB.getDb();
    return await dbHandle.query(table);
  }

  static Future<sql.Database> getDb() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(INIT_SQL_QUERIES[0]);
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> values) async {
    final dbHandle = await DB.getDb();
    dbHandle.insert(
      table,
      values,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
