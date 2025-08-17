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
    setState(() {
      selectedMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        color: const Color(0xFFF7E7CE),
        child: DropdownMenu<ModeSelectionItem>(
          initialSelection: modeSelectionItems.first,
          width: 350,
          controller: widget.menuController,
          requestFocusOnTap: true,
          onSelected: (ModeSelectionItem? mode) {
            selectCalculatorMode(mode);
          },
          dropdownMenuEntries: modeSelectionItems
              .map<DropdownMenuEntry<ModeSelectionItem>>(
                (ModeSelectionItem mode) {
                  return DropdownMenuEntry<ModeSelectionItem>(
                    value: mode,
                    label: mode.label,
                  );
                },
              )
              .toList(),
        ),
      ),
    );
  }
}