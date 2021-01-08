import 'package:listadecompras/models/produto.dart';

class Compras {
  int _id;
  String _nome;

  Compras();

  fromMap(Map<String, dynamic> map) {
    this._id = map['compras_id'];
    this._nome = map['nome'];
  }

  Map<String, dynamic> toMap() {
    return {'id': this._id, 'nome': this._nome};
  }
}
