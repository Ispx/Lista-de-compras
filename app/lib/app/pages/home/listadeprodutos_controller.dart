import 'package:listadecompras/app/interfaces/databasefactory_interface.dart';
import 'package:listadecompras/app/models/produto.dart';
import 'package:listadecompras/app/services/sqflite/factorys/produtos_factory.dart';
import 'package:mobx/mobx.dart';
part "listadeprodutos_controller.g.dart";

class ListaDeProdutosController = ListaDeProdutosControllerBase
    with _$ListaDeProdutosController;

abstract class ListaDeProdutosControllerBase with Store {
  IDatabaseFactory _produtoFactory = ProdutoFactory();

  @observable
  Future<List<Produto>> listaDeProdutos;

  ListaDeComprasControllerBase() {
    listaDeProdutos = obterListaDeProdutos();
  }

  @action
  Future<int> increment(Produto produto) async {
    _produtoFactory.atualizar(produto.id, produto);
    listaDeProdutos = obterListaDeProdutos();

    return 0;
  }

  @action
  Future<int> decrement(Produto produto) async {
    if (produto.quantidade == 1) {
      return 0;
    }
    produto.quantidade--;
    _produtoFactory.atualizar(produto.id, produto);
    listaDeProdutos = obterListaDeProdutos();
    return 0;
  }

  @action
  Future<int> deletar(produto) async {
    int id = await _produtoFactory.deletar(produto.id);
    listaDeProdutos = obterListaDeProdutos();
    return id;
  }

  @action
  Future<List<Produto>> obterListaDeProdutos() async {
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
    listaDeProdutos = obterListaDeProdutos();
  }

  @action
  Future<Iterable<Produto>> produtosId(int id) async {
    List<Map<String, dynamic>> produtos = await _produtoFactory.ler();
    List<Produto> listaDeProdutos = List<Produto>();
    List<Produto> listaDeProdutosWhere = List<Produto>();
    for (Map<String, dynamic> map in produtos) {
      Produto produto = Produto();
      produto.fromMap(map);
      listaDeProdutos.add(produto);
    }

    var produtosWhere =
        listaDeProdutos.where((element) => element.fklista == id);
    for (Produto produto in produtosWhere) {
      listaDeProdutosWhere.add(produto);
    }

    return listaDeProdutos.where((element) => element.fklista == id);
  }
}
