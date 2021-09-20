import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

import './../widgets/button.widget.dart';
import './../constants/keyboard.constant.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultado = Keyboard.NUMERO_0;
  String operaciones = Keyboard.VACIO;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora"),
        ),
        body: Column(
          children: [
            createInput(resultado),
            createInput(operaciones),
            createKeyboard(Button(getEvent))
          ],
        ));
  }

  getEvent(String caracter) {
    return () {
      setState(() {
        if (caracter == Keyboard.LIMPIAR) {
          operaciones = Keyboard.VACIO;
          resultado = Keyboard.NUMERO_0;
        } else if (caracter == Keyboard.BORRAR) {
          if (operaciones.isNotEmpty) {
            operaciones = operaciones.substring(0, operaciones.length - 1);
          }
        } else if (caracter == Keyboard.IGUAL) {
          resultado = realizarOperaciones(operaciones);
        } else if (caracter == Keyboard.POTENCIA_CUADRADA) {
          operaciones = "$operaciones²";
        } else {
          operaciones = "$operaciones$caracter";
        }
      });
    };
  }

  realizarOperaciones(String operaciones) {
    try {
      if (operaciones == Keyboard.VACIO) {
        return Keyboard.NUMERO_0;
      }

      var finalOperaciones = operaciones
          .replaceAll(Keyboard.DIVISION, "/")
          .replaceAll(Keyboard.MULTIPLIACION, "*")
          .replaceAll("²", "^2");

      Parser parser = new Parser();
      ContextModel contextModel = new ContextModel();
      Expression expressionFinal = parser.parse(finalOperaciones);
      return expressionFinal
          .evaluate(EvaluationType.REAL, contextModel)
          .toString();
    } catch (e) {
      return "Error de sintaxis";
    }
  }
}

createInput(String text, {int flex = 1, Color? color, Color? textColor}) {
  return Expanded(
    flex: flex,
    child: Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(color: color ?? Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor ?? Colors.white, fontSize: 30),
          )
        ],
      ),
    ),
  );
}

createKeyboard(Button button) {
  return Expanded(
      child: Container(
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
    child: Column(
      children: [
        Row(
          children: [
            button.createButtonText(Keyboard.NUMERO_7),
            button.createButtonText(Keyboard.NUMERO_8),
            button.createButtonText(Keyboard.NUMERO_9),
            button.createButtonText(Keyboard.DIVISION),
            button.createButtonText(Keyboard.BORRAR),
            button.createButtonText(Keyboard.LIMPIAR),
          ],
        ),
        Row(
          children: [
            button.createButtonText(Keyboard.NUMERO_4),
            button.createButtonText(Keyboard.NUMERO_5),
            button.createButtonText(Keyboard.NUMERO_6),
            button.createButtonText(Keyboard.MULTIPLIACION),
            button.createButtonText(Keyboard.PARENTESIS_ABIERTO),
            button.createButtonText(Keyboard.PARENTESIS_CERRADO),
          ],
        ),
        Row(
          children: [
            button.createButtonText(Keyboard.NUMERO_1),
            button.createButtonText(Keyboard.NUMERO_2),
            button.createButtonText(Keyboard.NUMERO_3),
            button.createButtonText(Keyboard.RESTA),
            button.createButtonText(Keyboard.POTENCIA_CUADRADA),
            button.createButtonText(Keyboard.RAIZ_CUADRADA),
          ],
        ),
        Row(
          children: [
            button.createButtonText(Keyboard.NUMERO_0),
            button.createButtonText(Keyboard.PUNTO),
            button.createButtonText(Keyboard.PORCENTAJE),
            button.createButtonText(Keyboard.SUMA),
            button.createButtonText(Keyboard.IGUAL,
                flex: 2, color: Colors.green)
          ],
        ),
      ],
    ),
  ));
}
