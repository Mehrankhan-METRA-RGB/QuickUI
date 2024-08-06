import 'package:flutter/material.dart';
import 'package:quick_ui/quick_ui.dart';

class QuickFramExample extends StatefulWidget {
  const QuickFramExample({super.key});

  @override
  State<QuickFramExample> createState() => _QuickFramExampleState();
}

class _QuickFramExampleState extends State<QuickFramExample> {
  late QuickFrame? quickFrame;
  @override
  void initState() {
    quickFrame = QuickFrame(
      textStyle: TextStyle(),
      physics: const BouncingScrollPhysics(),
      pageScreens: [Center(child: Text('HomeScreen')), Center(child: Text('ApplcationScreen')  ),Center(child: Text('HomeScreen')), Center(child: Text('ApplcationScreen')  )],
      bottomElements: [
        BottomModel(path: 'assets/applicationNotfilled.svg', title: ' Application',selectedColor: Colors.red,unSelectedColor: Colors.black,offset: const Offset(-15, 0)),
        BottomModel(path: 'assets/homeNotFilled.svg', title: 'Home',selectedColor: Colors.red,unSelectedColor: Colors.black,offset: const Offset(-20, 0)),
        BottomModel(path: 'assets/applicationNotfilled.svg', title: ' Application',selectedColor: Colors.red,unSelectedColor: Colors.black),
        BottomModel(path: 'assets/homeNotFilled.svg', title: 'Home',selectedColor: Colors.red,unSelectedColor: Colors.black)
      ],
      onPageChanged: (int pageVal) {

        print('Page changed to $pageVal');
      },
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton:  FloatingActionButton(onPressed: () {  },),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: quickFrame!.bottomBar,
      body: quickFrame!.pageWidget,

    );
  }
}
