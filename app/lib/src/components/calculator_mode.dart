import 'package:flutter/material.dart';

class ModeSelectionItem {
  final int id;
  final String label;

  ModeSelectionItem(this.id, this.label);
}

class CalculatorMode extends StatefulWidget {
  const CalculatorMode({
    super.key,
    required this.menuController,
  });

  final TextEditingController menuController;

  @override
  State<CalculatorMode> createState() => _CalculatorModeState();
}

class _CalculatorModeState extends State<CalculatorMode> {
  List<ModeSelectionItem> modeSelectionItems = [
    ModeSelectionItem(1, 'Basic'),
  ];

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