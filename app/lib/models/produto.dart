class Produto {
  int _id;
  String _nome;
  int _quantidade = 1;

  Produto(this._id, this._nome, this._quantidade);

  set id(int id) => _id = id;
  get quantidade => this._quantidade;

  set quantidade(int valor) => this._quantidade = valor;

  get nome => this._nome;

  get id => this._id;

  Map<String, dynamic> getMap() {
    return {'produto_id': _id, 'nome': _nome, 'quantidade': _quantidade};
  }

  setId(int id) => _id = id;

  void increment() {
    if (_quantidade == 99) {
      return;
    }
    _quantidade++;
  }

  void decrement() {
    if (_quantidade == 1) {
      return;
    }
    _quantidade--;
  }
}
