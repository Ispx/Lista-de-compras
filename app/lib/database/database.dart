import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = await getDatabasesPath();
  final String nomeDb = "produtos.db";

  return openDatabase(join(path, nomeDb), onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE produtos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, quantidade INTEGER)");
  }, version: 1);
}
