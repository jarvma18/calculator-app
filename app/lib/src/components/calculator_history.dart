import 'package:flutter/material.dart';

class CalculatorHistory extends StatelessWidget {
  const CalculatorHistory({
    super.key,
    required this.historyItems,
  });

  final List<String> historyItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: historyItems.length,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text(historyItems[index])),
          );
        }
      ),
    );
  }
}
