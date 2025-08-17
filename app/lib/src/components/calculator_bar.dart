import 'package:flutter/material.dart';

class CalculatorBar extends StatelessWidget {
  const CalculatorBar({
    super.key,
    required this.calculatorController,
  });

  final TextEditingController calculatorController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF9BCDB0),
      child: SizedBox(
      width: 350,
      height: 50,
      child: TextField(
        readOnly: true,
        controller: calculatorController,
        textAlign: TextAlign.center,
      ),
      ),
    );
  }
}