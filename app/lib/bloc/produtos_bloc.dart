import 'dart:async';

import 'package:listadecompras/models/model_factory.dart';
import 'package:listadecompras/models/produto.dart';
import 'package:listadecompras/models/produtos_factory.dart';

class ProdutosBloc implements ModelFactory {
  StreamController<List<Produto>> _streamController =
      StreamController<List<Produto>>();

  Stream<List<Produto>> get output => _streamController.stream;

  Sink<List<Produto>> get input => _streamController.sink;

  void increment(Produto produto) {
    produto.quantidade++;
    ProdutoFactory().atualizar(produto.id, produto);
    ler();
  }

  void decrement(Produto produto) {
    if (produto.quantidade == 1) {
      return;
    }
    produto.quantidade--;
    ProdutoFactory().atualizar(produto.id, produto);
    ler();
  }

  @override
  Future<int> atualizar(int id, values) {
    throw UnimplementedError();
  }

  @override
  Future<int> deletar(produto) async {
    int id = await ProdutoFactory().deletar(produto.id);
    ler();
    return id;
  }

  @override
  fechar() {
    if (!_streamController.isClosed) {
      _streamController.close();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    List<Map<String, dynamic>> produtos = await ProdutoFactory().ler();
    List<Produto> listaDeProdutos = List<Produto>();
    for (Map<String, dynamic> map in produtos) {
      Produto produto = Produto();
      produto.fromMap(map);
      listaDeProdutos.add(produto);
    }
    input.add(listaDeProdutos);
    return produtos;
  }

  @override
  Future<int> inserir(produto) async {
    int id = await ProdutoFactory().inserir(produto);
    ler();
    return id;
  }
}
