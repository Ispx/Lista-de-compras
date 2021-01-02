import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget formProduto(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  return TextField(
    decoration: InputDecoration(
        hintText: "Informe um produto",
        suffix: FlatButton(
          child: Text("Adicionar"),
          onPressed: () {
            //criar produto
          },
        )),
  );
}
