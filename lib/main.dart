import 'package:flutter/material.dart';
import 'package:mailsaver/Models/ChangeNotifier.dart';
import 'package:provider/provider.dart';

import 'Components/AddComponent.dart';
import 'HomeScreen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => EmailsManager(),
        child: const HomeScreen(),
      ),
      routes: {
        '/add': (context) => const AddComponent()
      },
    );
  }
}

