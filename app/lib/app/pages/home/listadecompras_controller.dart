import 'package:listadecompras/app/models/compras.dart';
import 'package:listadecompras/app/services/sqflite/factorys/listadecompras_factory.dart';

class ListaDeComprasController {
  ListaDeComprasFactory _listaDeComprasFactory = ListaDeComprasFactory();

  adicionar(Compras compras) {
    _listaDeComprasFactory.inserir(compras);
  }
}
