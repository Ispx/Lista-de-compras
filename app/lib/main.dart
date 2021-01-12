import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/viewmodels/appmodular_viewmodel.dart';

void main() async {
  runApp(ModularApp(
    module: AppModularViewModel(),
  ));
  // deleteDatabaseApp();
}
