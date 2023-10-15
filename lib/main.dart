import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = '';
  String _currentInput = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _currentInput = '';
        _output = '';
      } else if (buttonText == '=') {
        try {
          final result = evaluateExpression(_currentInput);
          _output = result.toString();
        } catch (e) {
          _output = 'Error';
        }
      } else {
        _currentInput += buttonText;
      }
    });
  }

  double evaluateExpression(String expression) {
    return Function.apply(_parseExpression(expression), []);
  }

  Function _parseExpression(String expression) {
    try {
      mathFunc(String expr) {
        return (pow(double.parse(expr.split('^')[0]), double.parse(expr.split('^')[1])));
        }
      if (expression.contains('^')) {
        return mathFunc;
      }
    } catch (e) {}

    return () {
      try {
        return double.parse(expression);
      } catch (e) {
        return evalExpression(expression);
      }
    };
  }

  double evalExpression(String expression) {
    try {
      return Function.apply(Function.apply(_parseOperator(expression), []), []);
    } catch (e) {
      return double.parse(expression);
    }
  }

  Function _parseOperator(String expression) {
    if (expression.contains('+')) {
      return (double a, double b) => a + b;
    }
    if (expression.contains('-')) {
      return (double a, double b) => a - b;
    }
    if (expression.contains('*')) {
      return (double a, double b) => a * b;
    }
    if (expression.contains('/')) {
      return (double a, double b) => a / b;
    }
    if (expression.contains('sqrt')) {
      return (double a) => sqrt(a);
    }
    throw Exception('Operación no válida: $expression');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Científica'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              _output,
              style: TextStyle(fontSize: 36),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CalculatorButton(
                  buttonText: getButtonText(index),
                  onPressed: () {
                    _onButtonPressed(getButtonText(index));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getButtonText(int index) {
    if (index < 9) {
      return (index + 1).toString();
    } else if (index == 9) {
      return 'C';
    } else if (index == 10) {
      return '0';
    } else if (index == 11) {
      return '=';
    } else if (index == 12) {
      return '+';
    } else if (index == 13) {
      return '-';
    } else if (index == 14) {
      return '*';
    } else if (index == 15) {
      return '/';
    } else if (index == 16) {
      return '^';
    } else if (index == 17) {
      return 'sqrt(';
    } else if (index == 18) {
      return ')';
    }
    return '';
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  CalculatorButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
