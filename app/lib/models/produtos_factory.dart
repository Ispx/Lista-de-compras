import 'package:listadecompras/database/database.dart';
import 'package:listadecompras/models/produto.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoFactory {
  Database _database;
  final String _tableProdutos = "produtos";

  Future<int> salvar(Produto produto) async {
    _database = await createDatabase();
    return _database.insert(_tableProdutos, produto.getMap());
  }

  Future<int> edita(int id, Produto newProduto) async {
    _database = await createDatabase();
    return _database.update(_tableProdutos, newProduto.getMap(),
        where: "id = ?", whereArgs: [id]);
  }

  Future<List<Produto>> ler() async {
    _database = await createDatabase();
    List<Produto> listaDeProdutos = List<Produto>();
    List<Map<String, dynamic>> mapProdutos =
        await _database.query(_tableProdutos, orderBy: "nome ASC");

    for (Map<String, dynamic> map in mapProdutos) {
      Produto produto = new Produto(
        map['id'],
        map['nome'],
        map['quantidade'],
      );
      listaDeProdutos.add(produto);
    }
    return listaDeProdutos;
  }

  Future<List<Map<String, dynamic>>> obterProdutos() async {
    _database = await createDatabase();
    List<Map<String, dynamic>> mapProdutos =
        await _database.query(_tableProdutos, orderBy: "nome ASC");

    return mapProdutos;
  }

  Future<int> deletar(int id) async {
    _database = await createDatabase();

    return _database.delete(_tableProdutos, where: "id = ?", whereArgs: [id]);
  }
}
