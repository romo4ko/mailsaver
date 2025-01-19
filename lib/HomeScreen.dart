import 'package:flutter/material.dart';
import 'package:mailsaver/Components/AddComponent.dart';

import 'Components/ListComponent.dart';
import 'Database/Database.dart';
import 'Models/Email.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isLeftCollapsed = false;
  bool isRightCollapsed = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleLeftCollapse() {
    setState(() {
      isLeftCollapsed = !isLeftCollapsed;
      isLeftCollapsed ? _animationController.forward() : _animationController.reverse();
    });
  }

  void toggleRightCollapse() {
    setState(() {
      isRightCollapsed = !isRightCollapsed;
      isRightCollapsed ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final leftWidth = isLeftCollapsed ? 0 : size.width / 3;
    final rightWidth = isRightCollapsed ? 0 : size.width / 3;
    final centerWidth = size.width - leftWidth - rightWidth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        leading: IconButton(
          onPressed: () {
            toggleLeftCollapse();
          },
          icon: const Icon(Icons.add),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                toggleRightCollapse();
              },
              icon: const Icon(Icons.download),
            ),
          ),
        ]),
      body: Row(
        children: [
          AnimatedContainer(
            width: leftWidth.toDouble(),
            duration: const Duration(milliseconds: 300),
            color: Colors.black12,
            child: !isLeftCollapsed ? const Center(
                child: AddComponent()
            ) : Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(
                color: Colors.green,
                child: const ListComponent()
            ),
          ),
          AnimatedContainer(
            width: rightWidth.toDouble(),
            duration: const Duration(milliseconds: 300),
            color: Colors.red,
            child: !isRightCollapsed ? Center(
                child: ElevatedButton(onPressed: toggleRightCollapse, child: const Text('Toggle Right'))
            ) : Container(),
          ),
        ],
      ),
    );
  }
}
