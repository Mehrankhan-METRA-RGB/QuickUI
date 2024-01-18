import 'package:flutter/material.dart';
import 'package:quick_ui/Widgets/Bars/simple_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUICK UI',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SimpleBottomBar(
            items: [
              BarItem(
                icon: Icons.add,
                activeIcon: Icons.access_time,
                index: 0,
                selectedIndex: 0,
                onTap: (int index) {},
              ),
              BarItem(
                icon: Icons.ac_unit,
                activeIcon: Icons.access_time_filled,
                index: 0,
                selectedIndex: 0,
                onTap: (int index) {},
              ),
              BarItem(
                icon: Icons.add_chart,
                activeIcon: Icons.add_chart,
                index: 0,
                selectedIndex: 0,
                onTap: (int index) {},
              ),
            ],
            onChange: (int index) {},
          )
        ],
      ),
    );
  }
}
