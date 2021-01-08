import 'package:listadecompras/database/createdatabase.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoFactory implements ModelFactory {
  Future<Database> _futureDb;
  Database _database;
  final String _TABLENAME = "produto";

  ProdutoFactory() {
    _futureDb = createTableDatabase(
        sql:
            "CREATE TABLE IF NOT EXISTS produto(produto_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, quantidade INTEGER NOT NULL)",
        versao: 1);
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
}
