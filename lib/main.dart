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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
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
        body: const SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _initialised = Future<bool>.value(false);
  final WordSquare _game = WordSquare();

  @override
  void initState() {
    super.initState();
    _initialised = _game.init().then((value) {
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialised,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData && snapshot.data == true) {
          children = [
            Board(_game),
          ];
        } else {
          children = [
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ];
        }
        return Stack(children: children);
      },
    );
  }
}
