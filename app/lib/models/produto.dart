class Produto {
  int _id;
  String _nome;
  int _quantidade;

  Produto(this._id, this._nome, this._quantidade);

  get quantidade => this._quantidade;

  set quantidade(int i) => this._quantidade += i;

  get nome => this._nome;

  Map<String, dynamic> getMap() {
    return {'id': _id, 'nome': _nome, 'quantidade': _quantidade};
  }

  setId(int id) => _id = id;
}
