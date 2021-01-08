import 'package:flutter/material.dart';
import 'package:listadecompras/pages/home.dart';

void main() async {
  runApp(MyApp());
  // deleteDatabaseApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
