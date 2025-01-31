import 'package:app/main.dart';
import 'package:flutter/material.dart';

class CalculationMode extends StatefulWidget {
  const CalculationMode({
    super.key,
    required this.menuController,
  });

  final TextEditingController menuController;

  @override
  State<CalculationMode> createState() => _CalculationModeState();
}

class _CalculationModeState extends State<CalculationMode> {
  ModeSelectionItem? selectedMode;

  void selectCalculatorMode(ModeSelectionItem? mode) {
    return setState(() {
      selectedMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<ModeSelectionItem>(
      initialSelection: modeSelectionItems.first,
      width: 250,
      controller: widget.menuController,
      requestFocusOnTap: true,
      onSelected: (ModeSelectionItem? mode) {
        selectCalculatorMode(mode);
      },
      dropdownMenuEntries: modeSelectionItems
        .map<DropdownMenuEntry<ModeSelectionItem>>((ModeSelectionItem mode) {
          return DropdownMenuEntry<ModeSelectionItem>(
            value: mode,
            label: mode.label
          );
        },
      ).toList(),
    );
  }
}