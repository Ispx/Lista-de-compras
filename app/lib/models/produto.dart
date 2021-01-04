class Produto {
  int _id;
  String _nome;
  int _quantidade = 1;
  Produto();
  get quantidade => this._quantidade;
  set quantidade(int valor) {
    this._quantidade = valor;
  }

  get nome => this._nome;
  get id => this._id;
  Map<String, dynamic> toMap() {
    return {'produto_id': _id, 'nome': _nome, 'quantidade': _quantidade};
  }

  void fromMap(Map<String, dynamic> map) {
    this._id = map['produto_id'];
    this._nome = map['nome'];
    this._quantidade = map['quantidade'];
  }
}
