import 'package:listadecompras/app/models/lista.dart';
import 'package:listadecompras/app/services/sqflite/factorys/listadecompras_factory.dart';

class ListaDeComprasController {
  ListaDeComprasFactory _listaDeComprasFactory = ListaDeComprasFactory();

  Future<int> adicionar(Map compras) {
    return _listaDeComprasFactory.inserir(compras);
  }

  Future<String> getNome(int id) async {
    Map map = await _listaDeComprasFactory.getItem(id);
    String nome = await map['nome'];
    return nome;
  }

  Future<List<Lista>> listaDeCompras() async {
    List<Lista> listas = List();
    Lista lista = Lista();
    Map map;
    List<Map<String, dynamic>> maps = await _listaDeComprasFactory.ler();

    for (map in maps) {
      lista.fromMap(map);
      listas.add(lista);
    }

    return listas;
  }
}
