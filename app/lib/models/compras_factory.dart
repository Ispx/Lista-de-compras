import 'package:listadecompras/database/createdatabase.dart';
import 'package:listadecompras/models/model_factory.dart';
import 'package:sqflite/sqflite.dart';

class ComprasFactory implements ModelFactory {
  Future<Database> _database;

  ComprasFactory() {
    this._database = createDatabase(
        nomeBancoDeDados: 'compras.db',
        sql:
            'CREATE TABLE IF NOT EXISTS compras(compras_id INTEGER NOT NULL, nome TEXT NOT NULL, fk_produto INTEGER NOT NULL, FOREIGN KEY(fk_produto) REFERENCES produto(produto_id))',
        versao: 1);
  }

  @override
  Future<int> atualizar(int id, values) {
    throw UnimplementedError();
  }

  @override
  Future<int> deletar(values) {
    throw UnimplementedError();
  }

  @override
  fechar() {
    throw UnimplementedError();
  }

  @override
  Future<int> inserir(values) {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> ler() {
    throw UnimplementedError();
  }
}
