import 'package:mobx/mobx.dart';

class ProdutosController {
  Observable<int> quantidade = Observable<int>(1);
  Action increment;

  ProdutosController() {
    increment = Action(_incrementAction());
  }

  _incrementAction() {
    quantidade.value = quantidade.value + 1;
  }

  _decrementAction() {
    if (quantidade.value >= 2) {
      quantidade.value = quantidade.value - 1;
    }
  }
}
