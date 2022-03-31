import 'package:flutter/material.dart';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression=equation;
        expression=expression.replaceAll("÷", "/");
        expression=expression.replaceAll("×", "*");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor, Color TextColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      //color: buttonColor,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FlatButton(
           color: buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
          ),
          padding: EdgeInsets.all(16),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              color: TextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Calculator"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(

          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: 38.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.redAccent, Colors.black),
                        buildButton("⌫", 1, Colors.black,Colors.white),
                        buildButton("÷", 1, Colors.black,Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.white, Colors.black),
                        buildButton("8", 1, Colors.white, Colors.black),
                        buildButton("9", 1, Colors.white, Colors.black),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.white,Colors.black),
                        buildButton("5", 1, Colors.white,Colors.black),
                        buildButton("6", 1, Colors.white,Colors.black),
                      ]),
                      TableRow(children: [
                        buildButton("3", 1, Colors.white,Colors.black),
                        buildButton("2", 1, Colors.white,Colors.black),
                        buildButton("1", 1, Colors.white,Colors.black),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.white,Colors.black),
                        buildButton("0", 1, Colors.white,Colors.black),
                        buildButton("00", 1, Colors.white,Colors.black),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("×", 1, Colors.black,Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("-", 1, Colors.black,Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("+", 1, Colors.black,Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("=", 2, Colors.redAccent,Colors.black),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
    ;
  }
}
