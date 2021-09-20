import 'package:flutter/material.dart';

class Button {
  Function(String caracter) event;
  Button(this.event);

  createButtonText(String text, {int flex = 1, Color? color}) {
    var onPressed = event(text);
    return createButton(Text(text), onPressed,  flex: flex, color: color);
  }

  createButton(Widget widget, Function() onPressed,{int flex = 1, Color? color}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: widget,
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.grey,
          )
        ),
      )
    );
  }
}
