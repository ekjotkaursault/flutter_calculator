import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _justPressedOperator = false;
  String _pressedButton = '';

  @override
  void initState() {
    super.initState();
    _loadLastValue();
  }

  Future<void> _loadLastValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _display = prefs.getString('lastValue') ?? '0';
    });
  }

  Future<void> _saveLastValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastValue', value);
  }

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = '0';
        _firstOperand = null;
        _operator = null;
        _justPressedOperator = false;
      } else if (value == 'CE') {
        _display = '0';
      } else if ('+-*/'.contains(value)) {
        if (_display.endsWith((r'[+\-*/]'))) return;
        _firstOperand =
            double.tryParse(_display.replaceAll(RegExp(r'[^0-9.]'), ''));
        _operator = value;
        _display += value;
        _justPressedOperator = true;
      } else if (value == '=') {
        final parts = _display.split(RegExp(r'[+\-*/]'));
        if (parts.length >= 2) {
          final secondOperand = double.tryParse(parts.last);
          if (_firstOperand != null && _operator != null && secondOperand != null) {
            double result = 0;
            switch (_operator) {
              case '+':
                result = _firstOperand! + secondOperand;
                break;
              case '-':
                result = _firstOperand! - secondOperand;
                break;
              case '*':
                result = _firstOperand! * secondOperand;
                break;
              case '/':
                result = secondOperand == 0 ? double.nan : _firstOperand! / secondOperand;
                break;
            }

            String resultStr = result.toStringAsFixed(2);
            if (resultStr.length > 10) {
              _display = 'OVERFLOW';
            } else if (result.isNaN) {
              _display = 'ERROR';
            } else {
              _display = resultStr;
              _saveLastValue(_display);
            }
          }
        }

        _firstOperand = null;
        _operator = null;
        _justPressedOperator = false;
      } else {
        if (_display == '0' || _display == 'OVERFLOW' || _display == 'ERROR') {
          _display = value;
        } else if (_justPressedOperator) {
          _display += value;
        } else if (_display.length < 12) {
          _display += value;
        } else {
          _display = 'OVERFLOW';
        }

        _justPressedOperator = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['CE', '0', 'C', '+'],
      ['=']
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF3),
      appBar: AppBar(
        title: const Text(
          'Flutter Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF4CC),
        elevation: 2,
      ),
      body: Center(
        child: Container(
          width: 360,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Display Area
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  _display,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Divider(height: 1, color: Colors.black12),
              // Buttons
              ...buttons.map((row) {
                return Expanded(
                  child: Row(
                    children: row.map((btnText) {
                      final isOperator = '+-*/='.contains(btnText);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: AnimatedScale(
                            scale: _pressedButton == btnText ? 0.95 : 1.0,
                            duration: const Duration(milliseconds: 100),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() => _pressedButton = btnText);
                                _onPressed(btnText);
                                Future.delayed(
                                  const Duration(milliseconds: 120),
                                  () => setState(() => _pressedButton = ''),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: btnText == '='
                                    ? Colors.lightBlueAccent
                                    : isOperator
                                        ? Colors.orangeAccent
                                        : Colors.white,
                                foregroundColor:
                                    isOperator ? Colors.white : Colors.black87,
                                padding: const EdgeInsets.all(22),
                              ),
                              child: Text(
                                btnText,
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
