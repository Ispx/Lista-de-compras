import 'package:listadecompras/app/services/sqflite/factorys/listadecompras_factory.dart';

class ListaDeComprasController {
  ListaDeComprasFactory _listaDeComprasFactory = ListaDeComprasFactory();

  Future<int> adicionar(Map compras) {
    return _listaDeComprasFactory.inserir(compras);
  }
}
