class Produto {
  int _id;
  String _nome;
  int _quantidade = 1;
  int _fklista;
  Produto();

  get quantidade => this._quantidade;
  set quantidade(int valor) {
    this._quantidade = valor;
  }

  get nome => this._nome;

  setNome(String nome) {
    this._nome = nome;
  }

  setFkLista(int id) {
    this._fklista = id;
  }

  int get id => this._id;
  Map<String, dynamic> toMap() {
    return {
      'produto_id': _id,
      'nome': _nome,
      'quantidade': _quantidade,
      'fk_lista': _fklista
    };
  }

  get fklista => _fklista;
  void fromMap(Map<String, dynamic> map) {
    this._id = map['produto_id'];
    this._nome = map['nome'];
    this._quantidade = map['quantidade'];
    this._fklista = map['fk_lista'];
  }
}
