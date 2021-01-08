import 'package:flutter/foundation.dart';
import 'package:listadecompras/models/produto.dart';
import 'package:mobx/mobx.dart';
part 'listaprodutoscontroller.g.dart';

class ListaProdutosController = ListaProdutosControllerBase
    with _$ListaProdutosController;

abstract class ListaProdutosControllerBase with Store {
  @observable
  List<Produto> produtos = List<Produto>();

  @action
  void inserir(Produto produto) {
    produtos.add(produto);
    print("ACTION INSERIR: " + produtos.toString());
  }

  @action
  remover(Produto produto) {
    produtos.remove(produto);
  }

  @action
  Future<int> increment(int index, Produto produto) async {
    produto.quantidade++;
    produtos[index] = produto;
    return 0;
  }

  @action
  Future<int> decrement(int index, Produto produto) async {
    if (produto.quantidade == 1) {
      return 0;
    }
    produto.quantidade--;
    produtos[index] = produto;
    return 0;
  }
}
