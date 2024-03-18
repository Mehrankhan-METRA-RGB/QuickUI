import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

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
        cardColor: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
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
  FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> listOfChip = [
    'String ',
    'int',
    'bool',
    'dynamic',
    'function',
  ];

  String? value;

  int activeIndex = 0;
  Offset offset = const Offset(50, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children:  [
           const SizedBox(height: 202,),



            /// Example of scrollable tab bar widget
            ScrollingTabs(
              physics: const NeverScrollableScrollPhysics(),
              childGap: 100,
              color: Colors.red,
              mainAxis: MainAxisAlignment.spaceBetween,
              buttons: const [
                QuickButton(
                height: 30,
                width: 80,
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Center(child: Text('Old'),),
              ),QuickButton(
                height: 30,
                width: 80,
                backgroundColor: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Center(child: Text('New'),),
              )], widgets:[
              Container(height: 100,width: 500,color: Colors.red,),
              Container(height: 100,width: 500,color: Colors.green,),
            ],),
          ],
        ),
      ),
    );
  }
}
