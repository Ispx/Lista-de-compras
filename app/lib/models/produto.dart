class Produto {
  int _id;
  String _nome;
  int _quantidade = 0;

  Produto(this._id, this._nome, this._quantidade);

  get quantidade => this._quantidade;

  set quantidade(int valor) => this._quantidade = valor;

  get nome => this._nome;

  get id => this._id;

  Map<String, dynamic> getMap() {
    return {'id': _id, 'nome': _nome, 'quantidade': _quantidade};
  }

  setId(int id) => _id = id;

  void increment() {
    _quantidade++;
  }

  void decrement() {
    if (_quantidade == 0) {
      return;
    }
    _quantidade--;
  }
}
