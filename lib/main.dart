import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator by delwarcse',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String expresstion = '';
  double equationFontSize = 45;
  double resultFontSize = 40;

  buttonOnPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        equationFontSize = 45;
        resultFontSize = 40;
        equation = '0';
        result = '0';
      } else if (buttonText == '←') {
        equationFontSize = 45;
        resultFontSize = 40;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 45;
        resultFontSize = 40;
        expresstion = equation;
        expresstion = expresstion.replaceAll('÷', '/');
        expresstion = expresstion.replaceAll('×', '*');
        expresstion = expresstion.replaceAll('%', '*0.01');
        expresstion = expresstion.replaceAll('π', '*3.1416');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expresstion);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        equationFontSize = 45;
        resultFontSize = 40;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonColor,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(24)),
      child: MaterialButton(
        onPressed: () {
          buttonOnPressed(buttonText);
        },
        padding: EdgeInsets.all(16),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff17171C),
      appBar: AppBar(
        title: Text('CALCULATOR'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    equation,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: equationFontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                color: Colors.white,
                fontSize: resultFontSize,
              ),
            ),
          ),
          Divider(
            height: 4,
          ),
          Row(
            children: [
              Container(
                width: screenSize.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton('AC', 0.80, Colors.red),
                      buildButton('←', 0.80, Colors.indigo),
                      buildButton('π', 0.80, Colors.indigo),
                    ]),
                    TableRow(children: [
                      buildButton('7', 0.88, Color(0xFF424242)),
                      buildButton('8', 0.80, Color(0xFF424242)),
                      buildButton('9', 0.80, Color(0xFF424242)),
                    ]),
                    TableRow(children: [
                      buildButton('4', 0.80, Color(0xFF424242)),
                      buildButton('5', 0.80, Color(0xFF424242)),
                      buildButton('6', 0.80, Color(0xFF424242)),
                    ]),
                    TableRow(children: [
                      buildButton('1', 0.80, Color(0xFF424242)),
                      buildButton('2', 0.80, Color(0xFF424242)),
                      buildButton('3', 0.80, Color(0xFF424242)),
                    ]),
                    TableRow(children: [
                      buildButton('00', 0.80, Color(0xFF424242)),
                      buildButton('.', 0.80, Color(0xFF424242)),
                      buildButton('0', 0.80, Color(0xFF424242)),
                    ]),
                    TableRow(children: [
                      buildButton('^', 0.80, Colors.green),
                      buildButton('(', 0.80, Colors.green),
                      buildButton(')', 0.80, Colors.green),
                    ]),
                  ],
                ),
              ),
              Container(
                  width: screenSize.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                          children: [buildButton('%', 0.80, Colors.indigo)]),
                      TableRow(
                          children: [buildButton('÷', 0.80, Colors.indigo)]),
                      TableRow(
                          children: [buildButton('×', 0.80, Colors.indigo)]),
                      TableRow(
                          children: [buildButton('-', 0.80, Colors.indigo)]),
                      TableRow(
                          children: [buildButton('+', 0.80, Colors.indigo)]),
                      TableRow(children: [
                        buildButton('=', 0.80, Colors.deepPurple)
                      ]),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
