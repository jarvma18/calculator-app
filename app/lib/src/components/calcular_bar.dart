import 'package:flutter/material.dart';

class CalculationBar extends StatelessWidget {
  const CalculationBar({
    super.key,
    required this.calculatorController,
  });

  final TextEditingController calculatorController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        readOnly: true,
        controller: calculatorController,
      ),
    );
  }
}