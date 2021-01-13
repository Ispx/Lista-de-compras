abstract class IDatabaseFactory {
  Future<Map> getItem(id);

  Future<int> inserir(dynamic values);

  Future<int> atualizar(int id, dynamic values);

  Future<List<Map<String, dynamic>>> ler();

  Future<int> deletar(dynamic values);

  Future<void> fechar();

  Future lerPorId(id);
}
