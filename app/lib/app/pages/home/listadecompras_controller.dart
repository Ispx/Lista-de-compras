import 'package:listadecompras/app/interfaces/databasefactory_interface.dart';
import 'package:listadecompras/app/models/produto.dart';
import 'package:listadecompras/app/services/sqflite/factorys/produtos_factory.dart';
import 'package:mobx/mobx.dart';
part "listadecompras_controller.g.dart";

class ListaDeComprasController = ListaDeComprasControllerBase
    with _$ListaDeComprasController;

abstract class ListaDeComprasControllerBase with Store {
  IDatabaseFactory _produtoFactory = ProdutoFactory();

  @observable
  Future<List<Produto>> listaDeProdutos;

  ListaDeComprasControllerBase() {
    listaDeProdutos = _obterListaDeProdutos();
  }

  @action
  Future<int> increment(Produto produto) async {
    _produtoFactory.atualizar(produto.id, produto);
    listaDeProdutos = _obterListaDeProdutos();

    return 0;
  }

  @action
  Future<int> decrement(Produto produto) async {
    if (produto.quantidade == 1) {
      return 0;
    }
    produto.quantidade--;
    _produtoFactory.atualizar(produto.id, produto);
    listaDeProdutos = _obterListaDeProdutos();
    return 0;
  }

  @action
  Future<int> deletar(produto) async {
    int id = await _produtoFactory.deletar(produto.id);
    listaDeProdutos = _obterListaDeProdutos();
    return id;
  }

  @action
  Future<List<Produto>> _obterListaDeProdutos() async {
    List<Map<String, dynamic>> produtos = await _produtoFactory.ler();
    List<Produto> listaDeProdutos = List<Produto>();
    for (Map<String, dynamic> map in produtos) {
      Produto produto = Produto();
      produto.fromMap(map);
      listaDeProdutos.add(produto);
    }
    return listaDeProdutos;
  }

  @action
  Future<dynamic> inserir(produto) async {
    await _produtoFactory.inserir(produto);
    listaDeProdutos = _obterListaDeProdutos();
  }
}
