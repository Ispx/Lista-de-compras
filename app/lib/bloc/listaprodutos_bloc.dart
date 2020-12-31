import 'dart:async';

import 'package:listadecompras/models/produto.dart';
import 'package:listadecompras/models/produtos_factory.dart';

class ListaDeProdutosBloc {
  StreamController<List<Produto>> _streamController =
      StreamController<List<Produto>>();

  Stream<List<Produto>> get output => _streamController.stream;

  Sink<List<Produto>> get input => _streamController.sink;

  void getProdutos() {
    ProdutoFactory()
        .ler()
        .then((listaDeProdutos) => input.add(listaDeProdutos));
  }
}
