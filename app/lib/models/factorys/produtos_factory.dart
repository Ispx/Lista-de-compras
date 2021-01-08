import 'package:listadecompras/database/createdatabase.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoFactory implements ModelFactory {
  Future<Database> _futureDb;
  Database _database;
  final _TABLENAME = "produto";

  ProdutoFactory() {
    _futureDb = createTableDatabaseApp();
  }

  @override
  Future<int> inserir(produto) async {
    _database = await this._futureDb;
    return _database.insert(_TABLENAME, produto.toMap());
  }

  @override
  Future<int> atualizar(int id, novoProduto) async {
    _database = await this._futureDb;
    return _database.update(_TABLENAME, novoProduto.toMap(),
        where: "produto_id = ?", whereArgs: [id]);
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    _database = await _futureDb;
    List<Map<String, dynamic>> mapProdutos =
        await _database.query(_TABLENAME, orderBy: "nome ASC");

    return mapProdutos;
  }

  @override
  Future<int> deletar(id) async {
    _database = await _futureDb;
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
