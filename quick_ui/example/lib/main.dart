import 'package:example/cropper.dart';
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
        cardColor: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(),
          border: UnderlineInputBorder(),
          errorBorder: UnderlineInputBorder(),
        ),
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
    final theme = Theme.of(context);
    print("BUILD CALL     ${theme.inputDecorationTheme}");
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            const SizedBox(height: 50),
            InputFields(
              // border: OutlineInputBorder(),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required Filed';
                }
                return null;
              },
              // unFocusedColor: Colors.grey.withOpacity(0.3),
              focusedColor: Colors.green,
              borderColor: Colors.yellow,
              errorColor: Colors.red,

              label: const Text('label'),
              // focusNode: focusNode,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Email',
              prefixIcon: Icons.person,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            MaterialButton(
              onPressed: () {
                _formKey.currentState?.validate();
              },
              child: Text('hasf'),
            )
          ],
        ),
      ),
    );
  }
}
