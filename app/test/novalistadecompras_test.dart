import 'package:flutter_test/flutter_test.dart';
import 'package:listadecompras/app/models/produto.dart';
import 'package:mockito/mockito.dart';

class MockProduto extends Mock implements Produto {}

var produto = MockProduto();

void main() {
  test("Retorna um produtos", () {
    produto.setNome("pera");
    expect(produto, "pera");
  });
}
