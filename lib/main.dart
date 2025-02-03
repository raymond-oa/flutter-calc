import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raymond Owusu-Ansah Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _result = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "";
      } else if (value == "=") {
        try {
          final evaluator = const ExpressionEvaluator();
          final expression = Expression.parse(_expression);
          final evalResult = evaluator.eval(expression, {});
          _result = " = $evalResult";
        } catch (e) {
          _result = " Error";
        }
      } else if (value == "x²") {
        try {
          double number = double.tryParse(_expression) ?? 0;
          _expression = (number * number).toString();
          _result = "";
        } catch (e) {
          _result = " Error";
        }
      } else if (value == "%") {
        _expression += "%";
        _result = "";
      } else {
        _expression += value;
        _result = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raymond Owusu-Ansah Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_expression$_result',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 18, // Updated to fit new buttons
              itemBuilder: (context, index) {
                final buttons = [
                  "7", "8", "9", "/",
                  "4", "5", "6", "*",
                  "1", "2", "3", "-",
                  "C", "0", "=", "+",
                  "x²", "%" // New buttons
                ];
                final value = buttons[index];
                return ElevatedButton(
                  onPressed: () => _onButtonPressed(value),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
