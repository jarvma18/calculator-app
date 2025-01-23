import 'package:app/src/components/mode_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class ModeSelectionItem {
  final int id;
  final String label;

  ModeSelectionItem(this.id, this.label);
}

List<ModeSelectionItem> modeSelectionItems = [
  ModeSelectionItem(1, 'Basic'),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Calculator App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 21, 145)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // todo
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController menuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  ModeDropdownMenu(menuController: menuController),
                  Text('History here'),
                  Text('Active here'),
                  Text('Keyboard here')
              ],
            )
          )
        )
        );
      }
    );
  }
}
