import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/services/sqflite/factorys/produtos_factory.dart';
import 'package:listadecompras/app/viewmodels/appmodular_viewmodel.dart';

void main() async {
  runApp(ModularApp(
    module: AppModularViewModel(),
  ));

  ProdutoFactory produtoFactory = ProdutoFactory();
  produtoFactory.ler().then((value) {
    print(value.toString());
  });
  // deleteDatabaseApp();
}
