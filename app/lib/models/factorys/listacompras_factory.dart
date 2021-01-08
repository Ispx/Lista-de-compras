import 'package:listadecompras/database/createdatabase.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ListaComprasFactory implements ModelFactory {
  final _TABLENAME = 'listacompras';
  Future<Database> _futureDatabase;
  Database _database;

  ListaComprasFactory() {
    this._futureDatabase = createTableDatabase(
        sql:
            'CREATE TABLE IF NOT EXISTS listacompras(listacompras_id INTEGER PRIMARY KEY AUTOINCREMENT, fk_compras INTEGER NOT NULL, fk_produto INTEGER NOT NULL,' +
                'FOREIGN KEY(fk_produto) REFERENCES produto(produto_id),' +
                'FOREIGN KEY(fk_compras) REFERENCES compras(compras_id)',
        versao: 1);
  }

  @override
  Future<int> atualizar(int id, values) {
    // TODO: implement atualizar
    throw UnimplementedError();
  }

  @override
  Future<int> deletar(values) {
    // TODO: implement deletar
    throw UnimplementedError();
  }

  @override
  fechar() {
    // TODO: implement fechar
    throw UnimplementedError();
  }

  @override
  Future<int> inserir(values) async {
    this._database = await this._futureDatabase;
    return this._database.insert(_TABLENAME, values);
  }

  @override
  Future<List<Map<String, dynamic>>> ler() async {
    this._database = await this._futureDatabase;
    return this._database.query(this._TABLENAME);
  }
}
