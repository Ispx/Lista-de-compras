import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/models/produto.dart';

Widget quantidadeComponent(Produto produto) {
  return Container(
    height: 20,
    width: 20,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black,
    ),
    child: Align(
      child: Text(
        "" + produto.quantidade.toString(),
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );
}
