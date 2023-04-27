import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: "Mike's Simple Calculator"),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  double result = 0;
  void handleOperations(MathOperators? operator, firstNumber, secondNumber) {
    if(operator == MathOperators.addition) {
      result = firstNumber + secondNumber;
    }
    else if(operator == MathOperators.subtraction) {
      result = firstNumber - secondNumber;
    }
    else if(operator == MathOperators.multiplication) {
      result = firstNumber * secondNumber;
    }
    else {
      result = firstNumber / secondNumber;
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum MathOperators { temp, addition, subtraction, division, multiplication }

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  double? firstNumber;
  double? secondNumber;
  
  MathOperators? _operators = MathOperators.temp;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    double result = appState.result;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter the first number",
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter a number";
                    }
                    return null;
                  },
                  onChanged: (value) => firstNumber = double.parse(value),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter the second number",
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter a number";
                    }
                    return null;
                  },
                  onChanged: (value) => secondNumber = double.parse(value),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Radio(
                      value: MathOperators.addition,
                      groupValue: _operators,
                      onChanged: (MathOperators? value) {
                        setState(() {
                          _operators = value;
                          appState.handleOperations(_operators, firstNumber, secondNumber);
                        });
                      }
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.add,
                      ),
                    ),
                    Radio(
                      value: MathOperators.subtraction,
                      groupValue: _operators,
                      onChanged: (MathOperators? value) {
                        setState(() {
                          _operators = value;
                          appState.handleOperations(_operators, firstNumber, secondNumber);
                        });
                      }
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.remove,
                      ),
                    ),
                    Radio(
                      value: MathOperators.multiplication,
                      groupValue: _operators,
                      onChanged: (MathOperators? value) {
                        setState(() {
                          _operators = value;
                          appState.handleOperations(_operators, firstNumber, secondNumber);
                        });
                      }
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "*",
                        style: TextStyle(
                          fontSize: 24.0,
                        )
                      ),
                    ),
                    Radio(
                      value: MathOperators.division,
                      groupValue: _operators,
                      onChanged: (MathOperators? value) {
                        setState(() {
                          _operators = value;
                          appState.handleOperations(_operators, firstNumber, secondNumber);
                        });
                      }
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "/",
                        style: TextStyle(
                          fontSize: 20.0,
                        )
                      ),
                    ),
                  ]
                ),
                const SizedBox(height: 12.0),
                Text(
                  "Your result is: $result",
                  style: const TextStyle(
                    fontSize: 16.0,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
