import 'package:flutter/material.dart';

import './pages/home.page.dart';

void main() {
  runApp(MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora",
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
