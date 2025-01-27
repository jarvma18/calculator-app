import 'package:app/main.dart';
import 'package:flutter/material.dart';

class ModeDropdownMenu extends StatefulWidget {
  const ModeDropdownMenu({
    super.key,
    required this.menuController,
  });

  final TextEditingController menuController;

  @override
  State<ModeDropdownMenu> createState() => _ModeDropdownMenuState();
}

class _ModeDropdownMenuState extends State<ModeDropdownMenu> {
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