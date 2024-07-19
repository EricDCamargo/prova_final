import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  double? firstNumber;
  double? secondNumber;
  String operator = '';
  bool clear = false;

  void inputText(String digit) {
    setState(() {
      if (clear) {
        display = digit;
        clear = false;
      } else {
        if (display == '0') {
          display = digit;
        } else {
          display += digit;
        }
      }
    });
  }

  void inputOperator(String selectedOperator) {
    setState(() {
      if (display.isNotEmpty) {
        firstNumber = double.tryParse(display);
        operator = selectedOperator;
        clear = true;
      }
    });
  }

  void calculateResult() {
    setState(() {
      if (display.isNotEmpty) {
        secondNumber = double.tryParse(display);
        if (firstNumber != null && secondNumber != null) {
          switch (operator) {
            case '+':
              display = (firstNumber! + secondNumber!).toString();
              break;
            case '-':
              display = (firstNumber! - secondNumber!).toString();
              break;
            case '*':
              display = (firstNumber! * secondNumber!).toString();
              break;
            case '/':
              if (secondNumber != 0) {
                display = (firstNumber! / secondNumber!).toString();
              } else {
                display = 'Divisão por zero não é permitida';
              }
              break;
          }
          firstNumber = null;
          secondNumber = null;
          operator = '';
          clear = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              display,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildOperatorButton('/'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildOperatorButton('*'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildOperatorButton('-'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('0'),
                _buildButton('.'),
                _buildEqualButton(),
                _buildOperatorButton('+'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      display = '0';
                      firstNumber = null;
                      secondNumber = null;
                      operator = '';
                      clear = false;
                    });
                  },
                  child: Text('Limpar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        inputText(buttonText);
      },
      child: Text(buttonText),
    );
  }

  Widget _buildOperatorButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        inputOperator(buttonText);
      },
      child: Text(buttonText),
    );
  }

  Widget _buildEqualButton() {
    return ElevatedButton(
      onPressed: () {
        calculateResult();
      },
      child: Text('='),
    );
  }
}
