import 'package:listadecompras/app/models/produto.dart';
import 'package:listadecompras/app/services/sqflite/factorys/produtos_factory.dart';
import 'package:mobx/mobx.dart';
part 'novosprodutos_controller.g.dart';

class NovosProdutosController = NovosProdutosControllerBase
    with _$NovosProdutosController;

abstract class NovosProdutosControllerBase with Store {
  ProdutoFactory _produtoFactory = ProdutoFactory();
  @observable
  ObservableList<Produto> listaDeProduto = ObservableList();
  @action
  Future<List<Produto>> lerPorId(int id) async {
    List<Produto> produtosList;
    List<Map<String, dynamic>> futureMap = await _produtoFactory.lerPorId(id);
    for (Map map in futureMap) {
      Produto produto = Produto();
      produto.fromMap(map);
      produtosList.add(produto);
    }
    return produtosList;
  }

  Future<void> salvarBancoDeDados() async {
    for (Produto produto in listaDeProduto) {
      await _produtoFactory.inserir(produto);
    }
  }

  @action
  void inserir(Produto produto) {
    listaDeProduto.add(produto);
  }

  @action
  remover(Produto produto) {
    _produtoFactory.deletar(produto);
    listaDeProduto.remove(produto);
  }

  @action
  Future<int> increment(int index, Produto produto) async {
    produto.quantidade++;
//    produtos[index] = produto;
    return 0;
  }

  @action
  Future<int> decrement(int index, Produto produto) async {
    if (produto.quantidade == 1) {
      return 0;
    }
    produto.quantidade--;
    //  produtos[index] = produto;
    return 0;
  }
}
