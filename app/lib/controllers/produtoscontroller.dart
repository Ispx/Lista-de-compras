import 'package:listadecompras/models/produto.dart';
import 'package:listadecompras/models/produtos_factory.dart';
import 'package:mobx/mobx.dart';
part "produtoscontroller.g.dart";

class ProdutosController = ProdutosControllerBase with _$ProdutosController;

abstract class ProdutosControllerBase with Store {
  @observable
  Future<List<Produto>> listaDeProdutos;

  @observable
  int quantidade = 1;

  ProdutosControllerBase() {
    listaDeProdutos = _obterListaDeProdutos();
  }

  @action
  Future<int> increment(Produto produto) async {
    quantidade = produto.quantidade++;
    ProdutoFactory().atualizar(produto.id, produto);
    listaDeProdutos = _obterListaDeProdutos();

    return 0;
  }

  @action
  Future<int> decrement(Produto produto) async {
    if (produto.quantidade == 1) {
      return 0;
    }
    produto.quantidade--;
    ProdutoFactory().atualizar(produto.id, produto);
    listaDeProdutos = _obterListaDeProdutos();
    return 0;
  }

  @action
  Future<int> deletar(produto) async {
    int id = await ProdutoFactory().deletar(produto.id);
    listaDeProdutos = _obterListaDeProdutos();
    return id;
  }

  @action
  Future<List<Produto>> _obterListaDeProdutos() async {
    List<Map<String, dynamic>> produtos = await ProdutoFactory().ler();
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
    await ProdutoFactory().inserir(produto);
    listaDeProdutos = _obterListaDeProdutos();
  }
}
