import 'package:flutter/material.dart';
import 'package:listadecompras/models/factorys/compras_factory.dart';
import 'package:listadecompras/models/factorys/produtos_factory.dart';
import 'package:listadecompras/screen/listadecompras.dart';

void main() async {
  runApp(MyApp());

  ComprasFactory comprasFactory = ComprasFactory();
  Map<String, dynamic> map = Map();
  map['nome'] = 'compras do mês';

  comprasFactory.inserir(map);

  comprasFactory.ler().then((value) {
    value.forEach((element) {
      print(element);
    });
  });

  ProdutoFactory produtoFactory = ProdutoFactory();
  produtoFactory.ler().then((element) {
    element.forEach((element) {
      print(element.toString());
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaDeCOmpras(),
    );
  }
}
