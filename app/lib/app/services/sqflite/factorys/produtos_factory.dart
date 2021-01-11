import 'package:listadecompras/app/interfaces/databasefactory_interface.dart';
import 'package:listadecompras/app/services/sqflite/createdatabase.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoFactory implements IDatabaseFactory {
  Future<Database> _futureDatabase;
  Database _database;
  final _TABLENAME = "produto";

  ProdutoFactory() {
    _futureDatabase = CreateDatabaseService.instance.createDatabaseApp();
  }

  @override
  Future<int> inserir(produto) async {
    _database = await this._futureDatabase;
    return _database.insert(_TABLENAME, produto.toMap());
  }

  @override
  Future<int> atualizar(int id, novoProduto) async {
    _database = await this._futureDatabase;
    return _database.update(_TABLENAME, novoProduto.toMap(),
        where: "produto_id = ?", whereArgs: [id]);
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    _database = await _futureDatabase;
    List<Map<String, dynamic>> mapProdutos =
        await _database.query(_TABLENAME, orderBy: "nome ASC");

    return mapProdutos;
  }

  @override
  Future<int> deletar(id) async {
    _database = await _futureDatabase;
    return _database
        .delete(_TABLENAME, where: "produto_id = ?", whereArgs: [id]);
  }

  @override
  fechar() {
    if (_database.isOpen) {
      _database.close();
    }
  }

  @override
  Future<Map> getItem(id) {
    // TODO: implement getItem
    throw UnimplementedError();
  }
}
