import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorView(),
  ));
}

class CalculatorView extends StatefulWidget {
  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextEditingController _textController = TextEditingController();
  double first = 0;
  double second = 0;
  String result = "0";
  String operator = "";
  final List<String> buttons = [
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
    "="
  ];

  // This function is called when a button is pressed
  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Clear everything
        _textController.text = "";
        result = "0";
        first = 0;
        second = 0;
        operator = "";
      } else if (value == "←") {
        // Backspace: remove last character
        if (_textController.text.isNotEmpty) {
          _textController.text = _textController.text
              .substring(0, _textController.text.length - 1);
        }
      } else if (value == "=") {
        // Perform calculation
        second = double.tryParse(_textController.text) ?? 0;
        switch (operator) {
          case "+":
            result = (first + second).toString();
            break;
          case "-":
            result = (first - second).toString();
            break;
          case "*":
            result = (first * second).toString();
            break;
          case "/":
            if (second != 0) {
              result = (first / second).toString();
            } else {
              result = "Error";
            }
            break;
          case "%":
            result = (first % second).toString();
            break;
          default:
            result = _textController.text;
        }
        _textController.text = result;
        first = 0;
        second = 0;
        operator = "";
      } else if (["+", "-", "*", "/", "%"].contains(value)) {
        // Store the first number and operator
        first = double.tryParse(_textController.text) ?? 0;
        operator = value;
        _textController.text = "";
      } else {
        // Append value to the display (number or decimal point)
        _textController.text += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Display Text Field
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 30),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              // Calculator Button Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: buttons.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          buttons[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          _onButtonPressed(buttons[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}