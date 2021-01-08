import 'package:listadecompras/database/createdatabase.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ListaComprasFactory implements ModelFactory {
  final _TABLENAME = 'lista';
  Future<Database> _futureDatabase;
  Database _database;

  ListaComprasFactory() {
    this._futureDatabase = createTableDatabaseApp();
  }

  @override
  Future<int> atualizar(int id, values) {
    // TODO: implement atualizar
    throw UnimplementedError();
  }

  @override
  Future<int> deletar(values) {
    // TODO: implement deletar
    throw UnimplementedError();
  }

  @override
  fechar() {
    // TODO: implement fechar
    throw UnimplementedError();
  }

  @override
  Future<int> inserir(values) async {
    this._database = await this._futureDatabase;
    return this._database.insert(_TABLENAME, values);
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    this._database = await this._futureDatabase;
    return this._database.query(this._TABLENAME);
  }

  @override
  Future<Map> getItem(id) async {
    Map<String, dynamic> map = Map();
    this._database = await this._futureDatabase;
    List<Map> items = await this
        ._database
        .query(_TABLENAME, where: "lista_id = ?", whereArgs: id);

    if (items.isNotEmpty) {
      map = items.first;
    }
    return map;
  }
}
