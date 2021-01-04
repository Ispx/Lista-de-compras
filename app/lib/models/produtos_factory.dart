import 'package:listadecompras/database/database.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoFactory implements ModelFactory {
  Database _database;
  final String _TABELA_PRODUTO = "produto";

  @override
  Future<int> inserir(produto) async {
    _database = await createDatabase();
    return _database.insert(_TABELA_PRODUTO, produto.toMap());
  }

  @override
  Future<int> atualizar(int id, novoProduto) async {
    _database = await createDatabase();
    return _database.update(_TABELA_PRODUTO, novoProduto.toMap(),
        where: "produto_id = ?", whereArgs: [id]);
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    _database = await createDatabase();
    List<Map<String, dynamic>> mapProdutos =
        await _database.query(_TABELA_PRODUTO, orderBy: "nome ASC");

    return mapProdutos;
  }

  @override
  Future<int> deletar(id) async {
    _database = await createDatabase();

    return _database
        .delete(_TABELA_PRODUTO, where: "produto_id = ?", whereArgs: [id]);
  }

  @override
  fechar() {
    if (_database.isOpen) {
      _database.close();
    }
  }
}
