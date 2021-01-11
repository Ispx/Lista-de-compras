class ListaCompras {
  int _id;
  int _fkProduto;
  int _fkCompras;
  ListaCompras();

  fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fkCompras = map['fk_compras'];
    this._fkProduto = map['fk_produto'];
  }

  toMap() {
    return {
      'id': this._id,
      'fk_produto': this._fkProduto,
      'fk_compras': this._fkCompras
    };
  }
}
