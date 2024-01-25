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

  List<String> listOfChip = ['String ', 'int', 'bool', 'dynamic', 'function'];

  int activeIndex = 0;
  Offset offset = const Offset(50, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            const SizedBox(
              height: 50,
            ),

             Align(
               alignment: Alignment.centerLeft,
               child: QuickPopMenu(
                 textStyle: const TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.w200,
                 ),
                 iconSize: const Size(20, 20),
                 position: PopupMenuPosition.under,
                 icon: 'assets/icon.svg',
                 dividerWidth: 1,
                 dividerColor: Colors.black,
                 shapeBorder: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                     side: const BorderSide(color: Colors.black,width: 1)),
                onTab: (value,name) {
                  print("value in the UI $name");
                },
                boxConstraints: const BoxConstraints(
                  maxHeight: 110,
                  maxWidth: 90,
                  minHeight: 110,
                  minWidth: 90
                ),
                menuNames: const ['Block','Share','Add'],
                menuIcons: const ['assets/icon.svg','assets/icon.svg','assets/icon.svg',],
                           ),
             ),
            const SizedBox(
              height: 130,
            ),
            Wrap(
              children: listOfChip.map((e) {
                return QuickChip(
                  borderColor: Colors.grey,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  deleteIcon: const Icon(
                    Icons.ac_unit_sharp,
                    color: Colors.black,
                    size: 10,
                  ),
                  label: e,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 50,
            ),

            QuickButton(
              borderStyle: BorderStyle.solid,
              strokeAlign: 0.10,
              borderWidth: 1,
              height: 45,
              width: 30,
              gapWidth: 10,
              prefixIcon: 'assets/icon.svg',
              prefixColor: Colors.white,
              // suffixIcon: Icons.access_alarms_outlined,
              prefixSize: const Size(20, 20),
              // suffixSize: const Size(6, 6),
              buttonText: 'Continue with Apple',
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(30),
              borderColor: Colors.black,
            ),
            const SizedBox(height: 10,),
            QuickButton(
              height: 45,
              width: 30,
              buttonText: 'Saved',
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
           const SizedBox(height: 10),
            InputFields(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
             errorColor: Colors.red,
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(20),
             ),
              borderRadius: 30,
              fillColor: const Color(0xffFFFFFF),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Required Filed';
                }
                return null;
              },
              onChange: (value) {

              },
              unFocusedColor: const Color(0xffEEEEEE),
              focusedColor: Colors.black87,
              borderColor: (val) => val!,
              label: const Text('label'),
              focusNode: focusNode,
              // border: OutlineInputBorder(
              //   borderSide: const BorderSide(color: Colors.red),
              //   borderRadius: BorderRadius.circular(20),
              // ),
              hintText: 'Email',
              prefixIcon: Icons.person,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Center(child: Text('Tab'))),
            const SizedBox(
              height: 50,
            ),
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
            ),
            const QuickFloat(
              child: QuickImage(url: 'assets/icon.svg',height: 100,)
              //the desired offsets
            ),
            const SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
