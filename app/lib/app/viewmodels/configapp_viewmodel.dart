import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfigAppViewModel extends StatelessWidget {
  static final ConfigAppViewModel instance = ConfigAppViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras App',
      theme: themeApp(),
      initialRoute: '/',
      onGenerateRoute: (settings) => Modular.generateRoute(settings),
      navigatorKey: Modular.navigatorKey,
    );
  }

  ThemeData themeApp() {
    return ThemeData(primaryColor: Colors.purple[900]);
  }
}
