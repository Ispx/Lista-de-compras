class Lista {
  int _id;
  String _nome;

  Lista();

  setNome(String nome) {
    _nome = nome;
  }

  get nome => _nome;

  fromMap(Map<String, dynamic> map) {
    this._id = map['lista_id'];
    this._nome = map['nome'];
  }

  Map<String, dynamic> toMap() {
    return {'lista_id': this._id, 'nome': this._nome};
  }
}
