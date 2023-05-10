import 'package:flutter/material.dart';
import 'package:wordquare_mobile/game.dart';
import 'package:wordquare_mobile/widgets/board/board.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final WordSquare _game = WordSquare();

  @override
  void initState() {
    super.initState();
    _game.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('WordSquare'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Add your logic here for account button
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Add your logic here for settings button
                },
              ),
            ],
          ),
          body: SafeArea(child: Board(_game))),
    );
  }
}
