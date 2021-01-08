import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createTableDatabase({String sql, int versao}) async {
  final String path = await getDatabasesPath();
  final String nomeDb = 'dados.db';
  return openDatabase(join(path, nomeDb), onCreate: (db, version) {
    return db.execute(sql);
  }, version: versao);
}

/*
Future<Database> createDatabase(
    {String nomeBancoDeDados, String sql, int version}) async {
  final String path = await getDatabasesPath();
  final String nomeDb = "dados.db";
  return openDatabase(join(path, nomeDb), onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE IF NOT EXISTS produto(produto_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, quantidade INTEGER NOT NULL)");
  }, version: 1);
}
*/
