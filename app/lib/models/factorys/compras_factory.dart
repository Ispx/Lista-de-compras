import 'package:listadecompras/database/createdatabase.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ComprasFactory implements ModelFactory {
  Future<Database> _futureDb;
  Database _database;
  final _TABLENAME = 'compras';
  ComprasFactory() {
    this._futureDb = createTableDatabase(
        sql:
            'CREATE TABLE IF NOT EXISTS compras(compras_id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL)',
        versao: 1);
  }

  @override
  Future<int> atualizar(int id, values) {
    throw UnimplementedError();
  }

  @override
  Future<int> deletar(values) {
    throw UnimplementedError();
  }

  @override
  fechar() {
    throw UnimplementedError();
  }

  @override
  Future<int> inserir(values) async {
    this._database = await this._futureDb;
    return this._database.insert(_TABLENAME, values);
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    this._database = await this._futureDb;

    return await this._database.query(_TABLENAME);
  }
}
