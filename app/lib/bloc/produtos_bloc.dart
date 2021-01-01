import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/models/produto.dart';
import 'package:listadecompras/models/produtos_factory.dart';

class ProdutosBloc implements BlocBase {
  StreamController<List<Produto>> _streamController =
      StreamController<List<Produto>>();

  Stream<List<Produto>> get output => _streamController.stream;

  Sink<List<Produto>> get input => _streamController.sink;

  void getProdutos() {
    ProdutoFactory()
        .ler()
        .then((listaDeProdutos) => input.add(listaDeProdutos));
  }

  void increment(Produto produto) {
    print("Valor inicial: " + produto.quantidade.toString());
    produto.quantidade++;
    print("Valor incrementado: " + produto.quantidade.toString());
    ProdutoFactory().atualiza(produto.id, produto);
    getProdutos();
  }

  void decrement(Produto produto) {
    if (produto.quantidade == 0) {
      ProdutoFactory().atualiza(produto.id, produto);
      getProdutos();
      return;
    }
    produto.quantidade--;
    ProdutoFactory().atualiza(produto.id, produto);
    getProdutos();
  }

  void remove(Produto produto) {
    ProdutoFactory().deletar(produto.id);
    getProdutos();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
