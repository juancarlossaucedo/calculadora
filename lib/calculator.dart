import 'package:flutter/material.dart';
import 'dart:math';

class Calculadora extends StatefulWidget {
  @override
  State<Calculadora> createState() => _CalculatorState();
}


class _CalculatorState extends State<Calculadora> {
  String input = '';
  String output = '';
  Color equalButtonColor = Colors.deepOrangeAccent;
  Color OpercaionesColors= Colors.amberAccent;
  Color BorrarColors= Colors.lightGreenAccent;
  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          output = calculateResult();

          equalButtonColor = Colors.red;
        } catch (e) {
          output = 'Error';
        }
      } else if (buttonText =='AC'){
        if (input.isNotEmpty) {

          input = input.substring(0, input.length - 1);
        } else {
          input += buttonText;
        }

      } else if (buttonText == 'C') {
        input = '';
        output = '';
      } else {
        input += buttonText;
      }
    });
  }

  String calculateResult() {
    try {
      if (input.contains('+')) {
        final parts = input.split('+');
        if (parts.length == 2) {
          final num1 = double.parse(parts[0]);
          final num2 = double.parse(parts[1]);
          return (num1 + num2).toString();
        }
      } else if (input.contains('-')) {
        final parts = input.split('-');
        if (parts.length == 2) {
          final num1 = double.parse(parts[0]);
          final num2 = double.parse(parts[1]);
          return (num1 - num2).toString();
        }
      } else if (input.contains('*')) {
        final parts = input.split('*');
        if (parts.length == 2) {
          final num1 = double.parse(parts[0]);
          final num2 = double.parse(parts[1]);
          return (num1 * num2).toString();
        }
      } else if (input.contains('/')) {
        final parts = input.split('/');
        if (parts.length == 2) {
          final num1 = double.parse(parts[0]);
          final num2 = double.parse(parts[1]);
          if (num2 != 0) {
            return (num1 / num2).toString();
          } else {
            return 'Error: División por cero';
          }
        }
      } else if (input.startsWith('sqrt')) {
        final num = double.parse(input.substring(4)); // Quita 'sqrt' y convierte el resto en un número.
        if (num >= 0) {
          return sqrt(num).toString();
        } else {
          return 'Error: Raíz cuadrada de un número negativo';
        }
      } else if (input.startsWith('sin')) {
        final num = double.parse(input.substring(3)); // Quita 'sin' y convierte el resto en un número.
        return sin(num).toString();
      } else if (input.startsWith('cos')) {
        final num = double.parse(input.substring(3)); // Quita 'cos' y convierte el resto en un número.
        return cos(num).toString();
      }
    } catch (e) {
      return 'Error';
    }
    return 'Error: Operación no válida';
  }



  Widget buildButton(String buttonText) {

    if (RegExp(r'^[0-9]$').hasMatch(buttonText)) {
      // Muestra solo los botones de números del 0 al 9 en 3 filas y 3 columnas
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      );
    } else {
      // Para otros botones, como operadores y funciones, puedes decidir si mostrarlos o no.
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      );
    }

  }

  Widget buildBtn(String buttonText) {

    if (buttonText == '=') {
      // Utiliza el color que hemos definido para el botón igual
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 46.0, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(equalButtonColor),
          ),
        ),
      );
    } else {
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      );
    }

  }

  Widget buildOperaciones(String buttonText) {

    if (buttonText == 'sqrt'
        || buttonText == '*'
        || buttonText == '+'
        || buttonText == '-'
        || buttonText == '/'
    || buttonText == 'sin'
    || buttonText == 'cos') {
      // Utiliza el color que hemos definido para el botón igual
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(OpercaionesColors),
          ),
        ),
      );
    } else {
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      );
    }

  }

  Widget buildBorradores(String buttonText) {

    if (buttonText == 'C'
        || buttonText == 'AC') {
      // Utiliza el color que hemos definido para el botón igual
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(BorrarColors),
          ),
        ),
      );
    } else {
      return Expanded(
        child: OutlinedButton(
          onPressed: () => onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CACULADORA'),
      ),
      body: Column(
        children: [
        Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal:12),
        child: Text(
          input,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Text(
          output,
          style: TextStyle(fontSize: 46.0),
        ),
      ),
      Expanded(
        child: GridView.count(
          crossAxisCount: 4, // 4 columnas
          children: [
            'C',
            'AC',
            '/',
            'sqrt',
            '7',
            '8',
            '9',
            '*',
            '4',
            '5',
            '6',
            '-',
            '1',
            '2',
            '3',
            '+',
            '.',
            '0',
            'sin',
            'cos',
            '=', // Igual


          ].map((buttonText) {
            if (buttonText == '=') {
              return buildBtn(buttonText);
            } else if (buttonText == 'sqrt'
                || buttonText == '*'
                || buttonText == '+'
                || buttonText == '-'
                || buttonText == '/'
                || buttonText == 'sin'
                || buttonText == 'cos')
            {
              return buildOperaciones(buttonText);
            } else if (buttonText == 'C'
                || buttonText == 'AC'){
              return buildBorradores(buttonText);
            } else {
              return buildButton(buttonText);
            }
          }).toList(),
        ),
      ),
        ],
      ),
    );
  }
}