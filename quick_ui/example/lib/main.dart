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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            const SizedBox(
              height: 130,
            ),
            for (int i = 0; i < listOfChip.length; i++)
              QuickChip(
                avatar: 'assets/icon.svg',
                borderColor: i == activeIndex?Colors.black:Colors.yellowAccent,
                // backgroundColor: i == activeIndex? Colors.green:Colors.transparent,
                onTap: () {
                  activeIndex = i;
                  setState(() {

                  });
                },
                onDeleted: () {
                  listOfChip.remove(listOfChip[i]);
                  setState(() {

                  });
                },
                deleteIcon:Icon(Icons.abc_sharp),
                label: listOfChip[i],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                  side: BorderSide(color: Colors.transparent),
                ),


                // InputFields(
                //   validator: (value) {
                //     if(value!.isEmpty){
                //       return 'Required Filed';
                //     }
                //     return null;
                //   },
                //   unFocusedColor: Colors.yellow,
                //   borderColor: Colors.green,
                //   // validationText: 'Email Is Required',
                //   label: const Text('label'),
                //   focusNode:focusNode,
                //   border:  OutlineInputBorder(
                //     borderSide: const BorderSide(color: Colors.red),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   hintText: 'Email',
                //   suffixIcon: const Icon(Icons.add),
                //   prefixIcon: Icons.ac_unit_sharp,
                //   textStyle: const TextStyle(
                //     fontSize: 10,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.cyan,
                //   ),
                // ),
                // ElevatedButton(onPressed: () {
                //   if(_formKey.currentState!.validate()){
                //
                //   }
                //
                // }, child: const Center(child: Text('Tab')))

                // SimpleBottomBar(
                //   items: [
                //     BarItem(
                //       icon: Icons.add,
                //       activeIcon: Icons.access_time,
                //       index: 0,
                //       selectedIndex: 0,
                //       onTap: (int index) {},
                //     ),
                //     BarItem(
                //       icon: Icons.ac_unit,
                //       activeIcon: Icons.access_time_filled,
                //       index: 0,
                //       selectedIndex: 0,
                //       onTap: (int index) {},
                //     ),
                //     BarItem(
                //       icon: Icons.add_chart,
                //       activeIcon: Icons.add_chart,
                //       index: 0,
                //       selectedIndex: 0,
                //       onTap: (int index) {},
                //     ),
                //   ],
                //   onChange: (int index) {},
                // )
              ),

            Wrap(
              children: listOfChip.map((e) {
                return QuickChip(
                  borderColor:  Colors.yellowAccent,
                  backgroundColor: Colors.transparent,
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
                  // InputFields(
                  //   validator: (value) {
                  //     if(value!.isEmpty){
                  //       return 'Required Filed';
                  //     }
                  //     return null;
                  //   },
                  //   unFocusedColor: Colors.yellow,
                  //   borderColor: Colors.green,
                  //   // validationText: 'Email Is Required',
                  //   label: const Text('label'),
                  //   focusNode:focusNode,
                  //   border:  OutlineInputBorder(
                  //     borderSide: const BorderSide(color: Colors.red),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   hintText: 'Email',
                  //   suffixIcon: const Icon(Icons.add),
                  //   prefixIcon: Icons.ac_unit_sharp,
                  //   textStyle: const TextStyle(
                  //     fontSize: 10,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.cyan,
                  //   ),
                  // ),
                  // ElevatedButton(onPressed: () {
                  //   if(_formKey.currentState!.validate()){
                  //
                  //   }
                  //
                  // }, child: const Center(child: Text('Tab')))

                  // SimpleBottomBar(
                  //   items: [
                  //     BarItem(
                  //       icon: Icons.add,
                  //       activeIcon: Icons.access_time,
                  //       index: 0,
                  //       selectedIndex: 0,
                  //       onTap: (int index) {},
                  //     ),
                  //     BarItem(
                  //       icon: Icons.ac_unit,
                  //       activeIcon: Icons.access_time_filled,
                  //       index: 0,
                  //       selectedIndex: 0,
                  //       onTap: (int index) {},
                  //     ),
                  //     BarItem(
                  //       icon: Icons.add_chart,
                  //       activeIcon: Icons.add_chart,
                  //       index: 0,
                  //       selectedIndex: 0,
                  //       onTap: (int index) {},
                  //     ),
                  //   ],
                  //   onChange: (int index) {},
                  // )
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
