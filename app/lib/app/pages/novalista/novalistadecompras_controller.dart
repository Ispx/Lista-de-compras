import 'package:listadecompras/app/models/produto.dart';
import 'package:mobx/mobx.dart';
part 'novalistadecompras_controller.g.dart';

class NovaListaDeComprasController = NovaListaDeComprasControllerBase
    with _$NovaListaDeComprasController;

abstract class NovaListaDeComprasControllerBase with Store {
  @observable
  List<Produto> produtos = List<Produto>();

  @action
  void inserir(Produto produto) {
    produtos.add(produto);
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