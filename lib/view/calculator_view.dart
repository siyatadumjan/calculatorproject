import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  final _key = GlobalKey<FormState>();
  String operator = '';
  double first = 0;
  double second = 0;

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _textController.clear();
        first = 0;
        second = 0;
        operator = '';
      } else if (value == "<-") {
        _textController.text =
            _textController.text.substring(0, _textController.text.length - 1);
      } else if (value == "=") {
        try {
          second = double.tryParse(_textController.text) ?? 0;
          _textController.text =
              _evaluateExpression(first, second, operator).toString();
          first = double.tryParse(_textController.text) ?? 0;
          operator = '';
        } catch (e) {
          _textController.text = "Error";
        }
      } else if (value == "+" ||
          value == "-" ||
          value == "*" ||
          value == "/" ||
          value == "%") {
        first = double.tryParse(_textController.text) ?? 0;
        operator = value;
        _textController.clear();
      } else {
        _textController.text += value;
      }
    });
  }

  double _evaluateExpression(double first, double second, String operation) {
    switch (operation) {
      case "+":
        return first + second;
      case "-":
        return first - second;
      case "*":
        return first * second;
      case "/":
        return second / first;
      case "%":
        return second % first;
      default:
        return second;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
