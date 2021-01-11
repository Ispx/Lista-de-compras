import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateDatabaseService {
  List<String> _sqlTables = [
    "CREATE TABLE IF NOT EXISTS lista(lista_id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL)",
    "CREATE TABLE IF NOT EXISTS produto(produto_id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, quantidade INTEGER NOT NULL, fk_lista INTEGER NOT NULL)",
  ];

  static final CreateDatabaseService instance = CreateDatabaseService();

  Future<Database> createDatabaseApp() async {
    final String path = await getDatabasesPath();
    final String nomeDb = "listadecompras.db";
    return openDatabase(join(path, nomeDb), onCreate: (db, version) {
      _sqlTables.forEach((sql) {
        db.execute(sql);
      });
      return db;
    }, version: 1);
  }

  Future<void> deleteDatabaseApp() async {
    final String path = await getDatabasesPath();
    final String nomeDb = 'listadecompras.db';
    return await deleteDatabase(join(path, nomeDb));
  }
}
