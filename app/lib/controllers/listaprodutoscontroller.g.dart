// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listaprodutoscontroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListaProdutosController on ListaProdutosControllerBase, Store {
  final _$produtosAtom = Atom(name: 'ListaProdutosControllerBase.produtos');

  @override
  List<Produto> get produtos {
    _$produtosAtom.reportRead();
    return super.produtos;
  }

  @override
  set produtos(List<Produto> value) {
    _$produtosAtom.reportWrite(value, super.produtos, () {
      super.produtos = value;
    });
  }

  final _$incrementAsyncAction =
      AsyncAction('ListaProdutosControllerBase.increment');

  @override
  Future<int> increment(int index, Produto produto) {
    return _$incrementAsyncAction.run(() => super.increment(index, produto));
  }

  final _$decrementAsyncAction =
      AsyncAction('ListaProdutosControllerBase.decrement');

  @override
  Future<int> decrement(int index, Produto produto) {
    return _$decrementAsyncAction.run(() => super.decrement(index, produto));
  }

  final _$ListaProdutosControllerBaseActionController =
      ActionController(name: 'ListaProdutosControllerBase');

  @override
  void inserir(Produto produto) {
    final _$actionInfo = _$ListaProdutosControllerBaseActionController
        .startAction(name: 'ListaProdutosControllerBase.inserir');
    try {
      return super.inserir(produto);
    } finally {
      _$ListaProdutosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remover(Produto produto) {
    final _$actionInfo = _$ListaProdutosControllerBaseActionController
        .startAction(name: 'ListaProdutosControllerBase.remover');
    try {
      return super.remover(produto);
    } finally {
      _$ListaProdutosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
produtos: ${produtos}
    ''';
  }
}
